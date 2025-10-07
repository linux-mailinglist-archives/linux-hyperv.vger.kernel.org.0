Return-Path: <linux-hyperv+bounces-7130-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590BFBC046A
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Oct 2025 07:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F7B3A6F13
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Oct 2025 05:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A122264C9;
	Tue,  7 Oct 2025 05:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9efv9s8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2812264AA;
	Tue,  7 Oct 2025 05:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816548; cv=none; b=O1tbw3e8iNxPxa6mryP3a+4R41hOWtvDqYy0i94b0VHXtgLQiksIxIQS9/npe0yh9QsuEn4TwT+gcywvVU/B0qyw9LzLg8NmzKF13kDv5W1vvNj9kb9a+K3STHYnNWO6jsKb30o8UJloCG2qBeZAzafKbyCaq8gNQ0DC5tMsrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816548; c=relaxed/simple;
	bh=2nIEFFo9PgMnji0tHWyo3GRSaIlkwdtp4+O2fweT93k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mrmt7dUDKQx/EfsSR2huwL9s3VkzmdJlmx+tapwO/eEkVqm5VDu31e9Tob1s6zbt9lnm8CmFM+MNTFfllv9cEZSRw4WlNdu2E+NyrjND5T2vO/h9bdkToNkT3GUSqZIFY992Qkn1wnLcYwoTyyZugA5GfewvV1YHyrxOzWfCHeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9efv9s8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AC2C4CEF1;
	Tue,  7 Oct 2025 05:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759816547;
	bh=2nIEFFo9PgMnji0tHWyo3GRSaIlkwdtp4+O2fweT93k=;
	h=Date:From:To:Cc:Subject:From;
	b=b9efv9s8AJvltibiCrt8vh9HVtHTTvtssCaWUHYYkra42UeeFcJ4sCUrDnByv9k1S
	 J+Pp8PW0kO2CTgFO8BeVS5c1XaKH02MsWjfi4WqJ4oic7i41RPchhVbO0+O/vISsMZ
	 gUzLKao2kfLPQv6+v50MeoH2rUTo6fQY8vi4YWqzow8dLA7jr1ABnK3ke56VXSbwTt
	 1hcAEhu4YfS7pt7nIBVhQNZNeAvFYT8pK4w0H2eU+eBoevdi9SgUHPVHu92sJuJ1vm
	 C6cvh+wq6wWVmBGjNsQG2Tq+fSocILnRx0/1QB+D6bmp0g/5BxuYOoPsglMjRXMJ0w
	 sTHh0Y1F71cbA==
Date: Tue, 7 Oct 2025 05:55:46 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V patches for 6.18
Message-ID: <20251007055546.GF2051323@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20251006

for you to fetch changes up to b595edcb24727e7f93e7962c3f6f971cc16dd29e:

  hyperv: Remove the spurious null directive line (2025-10-02 21:21:24 +0000)

----------------------------------------------------------------
hyperv-next for v6.18
 - Unify guest entry code for KVM and MSHV (Sean Christopherson)
 - Switch Hyper-V MSI domain to use msi_create_parent_irq_domain() (Nam
   Cao)
 - Add CONFIG_HYPERV_VMBUS and limit the semantics of CONFIG_HYPERV (Mukesh
   Rathor)
 - Add kexec/kdump support on Azure CVMs (Vitaly Kuznetsov)
 - Deprecate hyperv_fb in favor of Hyper-V DRM driver (Prasanna Kumar T S
   M)
 - Miscellaneous enhancements, fixes and cleanups (Abhishek Tiwari, Alok
   Tiwari, Nuno Das Neves, Wei Liu, Roman Kisel, Michael Kelley))
----------------------------------------------------------------
Abhishek Tiwari (1):
      Drivers: hv: util: Cosmetic changes for hv_utils_transport.c

Alok Tiwari (3):
      Drivers: hv: vmbus: Clean up sscanf format specifier in target_cpu_store()
      Drivers: hv: vmbus: Fix sysfs output format for ring buffer index
      Drivers: hv: vmbus: Fix typos in vmbus_drv.c

Michael Kelley (1):
      Drivers: hv: Simplify data structures for VMBus channel close message

Mukesh Rathor (2):
      Drivers: hv: Add CONFIG_HYPERV_VMBUS option
      Drivers: hv: Make CONFIG_HYPERV bool

Nam Cao (1):
      x86/hyperv: Switch to msi_create_parent_irq_domain()

Nuno Das Neves (2):
      hyperv: Add missing field to hv_output_map_device_interrupt
      mshv: Add support for a new parent partition configuration

Prasanna Kumar T S M (2):
      fbdev/hyperv_fb: deprecate this in favor of Hyper-V DRM driver
      MAINTAINERS: Mark hyperv_fb driver Obsolete

Roman Kisel (1):
      hyperv: Remove the spurious null directive line

Sean Christopherson (4):
      mshv: Handle NEED_RESCHED_LAZY before transferring to guest
      entry/kvm: KVM: Move KVM details related to signal/-EINTR into KVM proper
      entry: Rename "kvm" entry code assets to "virt" to genericize APIs
      mshv: Use common "entry virt" APIs to do work in root before running guest

Vitaly Kuznetsov (1):
      x86/hyperv: Add kexec/kdump support on Azure CVMs

Wei Liu (1):
      clocksource: hyper-v: Skip unnecessary checks for the root partition

 MAINTAINERS                                 |  13 +-
 arch/arm64/kvm/Kconfig                      |   2 +-
 arch/arm64/kvm/arm.c                        |   3 +-
 arch/loongarch/kvm/Kconfig                  |   2 +-
 arch/loongarch/kvm/vcpu.c                   |   3 +-
 arch/riscv/kvm/Kconfig                      |   2 +-
 arch/riscv/kvm/vcpu.c                       |   3 +-
 arch/x86/hyperv/irqdomain.c                 | 111 ++++++++++-----
 arch/x86/hyperv/ivm.c                       | 211 +++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mshyperv.c              |  11 +-
 arch/x86/kvm/Kconfig                        |   2 +-
 arch/x86/kvm/vmx/vmx.c                      |   1 -
 arch/x86/kvm/x86.c                          |   3 +-
 drivers/Makefile                            |   2 +-
 drivers/clocksource/hyperv_timer.c          |  10 +-
 drivers/gpu/drm/Kconfig                     |   2 +-
 drivers/hid/Kconfig                         |   2 +-
 drivers/hv/Kconfig                          |  15 +-
 drivers/hv/Makefile                         |   4 +-
 drivers/hv/channel.c                        |   2 +-
 drivers/hv/hv_common.c                      |  22 +--
 drivers/hv/hv_utils_transport.c             |  10 +-
 drivers/hv/mshv.h                           |   2 -
 drivers/hv/mshv_common.c                    |  22 ---
 drivers/hv/mshv_root_main.c                 |  57 +++-----
 drivers/hv/vmbus_drv.c                      |  10 +-
 drivers/input/serio/Kconfig                 |   4 +-
 drivers/net/hyperv/Kconfig                  |   2 +-
 drivers/pci/Kconfig                         |   2 +-
 drivers/scsi/Kconfig                        |   2 +-
 drivers/uio/Kconfig                         |   2 +-
 drivers/video/fbdev/Kconfig                 |   7 +-
 drivers/video/fbdev/hyperv_fb.c             |   2 +
 include/asm-generic/mshyperv.h              |  19 ++-
 include/hyperv/hvgdk_mini.h                 |   2 -
 include/hyperv/hvhdk_mini.h                 |   1 +
 include/linux/{entry-kvm.h => entry-virt.h} |  19 +--
 include/linux/hyperv.h                      |   7 +-
 include/linux/kvm_host.h                    |  17 ++-
 include/linux/rcupdate.h                    |   2 +-
 kernel/entry/Makefile                       |   2 +-
 kernel/entry/{kvm.c => virt.c}              |  15 +-
 kernel/rcu/tree.c                           |   6 +-
 net/vmw_vsock/Kconfig                       |   2 +-
 virt/kvm/Kconfig                            |   2 +-
 45 files changed, 449 insertions(+), 193 deletions(-)
 rename include/linux/{entry-kvm.h => entry-virt.h} (83%)
 rename kernel/entry/{kvm.c => virt.c} (66%)

