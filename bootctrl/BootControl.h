#ifndef HARDWARE_INTERFACES_BOOTCTRL_V1_0_DIANA_BOOTCONTROL_H
#define HARDWARE_INTERFACES_BOOTCTRL_V1_0_DIANA_BOOTCONTROL_H

#include <android/hardware/boot/1.0/IBootControl.h>
#include <hidl/MQDescriptor.h>
#include <hidl/Status.h>

namespace android {
namespace hardware {
namespace boot {
namespace V1_0 {
namespace implementation {

using ::android::hardware::Return;
using ::android::hardware::Void;

class BootControl : public IBootControl {
public:
    BootControl();
    ~BootControl();

    Return<uint32_t> getNumberSlots() override;
    Return<uint32_t> getCurrentSlot() override;
    Return<void> markBootSuccessful() override;
    Return<void> setActiveBootSlot(uint32_t slot) override;
    Return<bool> isSlotBootable(uint32_t slot) override;
    Return<bool> isSlotMarkedSuccessful(uint32_t slot) override;
    Return<void> setSlotAsUnbootable(uint32_t slot) override;
    Return<size_t> getPartitionMetadataSize() override;

private:
    uint32_t currentSlot;  // Активный слот
};

}  // namespace implementation
}  // namespace V1_0
}  // namespace boot
}  // namespace hardware
}  // namespace android

#endif  // HARDWARE_INTERFACES_BOOTCTRL_V1_0_DIANA_BOOTCONTROL_H
