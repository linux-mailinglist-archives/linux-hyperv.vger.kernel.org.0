Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62427278CAF
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Sep 2020 17:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgIYP3f (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Sep 2020 11:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729141AbgIYP3e (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Sep 2020 11:29:34 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601047771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7Afe48pkEQZLqWPSXWRulCj196P+48pQyU4ztEKPbI=;
        b=ExCmKxePDxbZ5FJ4NYvz+U4pMum66vt1nGiAGB4Yr9GAYRs4ncKEwUuFBMFlNI4M3GKoHD
        yYAhSYAaf//wld4AjsRji1BD0gn+z2dHZw1pmczyHg0F+TsnPR0qzErhJdEXFBS95cqekK
        DwAQ7svzKraioPgeDvtY6Y0KqQcfOdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-CloU21ZHNWSunAjJZOKQ-g-1; Fri, 25 Sep 2020 11:29:26 -0400
X-MC-Unique: CloU21ZHNWSunAjJZOKQ-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19D6B10082EB;
        Fri, 25 Sep 2020 15:29:22 +0000 (UTC)
Received: from ovpn-66-87.rdu2.redhat.com (unknown [10.10.67.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4371D1002382;
        Fri, 25 Sep 2020 15:29:14 +0000 (UTC)
Message-ID: <3c12bdec2c4ecdabcccd9ece3d495d792e9fc231.camel@redhat.com>
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device
 MSI
From:   Qian Cai <cai@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 25 Sep 2020 11:29:13 -0400
In-Reply-To: <20200826111628.794979401@linutronix.de>
References: <20200826111628.794979401@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 2020-08-26 at 13:16 +0200, Thomas Gleixner wrote:
> This is the second version of providing a base to support device MSI (non
> PCI based) and on top of that support for IMS (Interrupt Message Storm)
> based devices in a halfways architecture independent way.
> 
> The first version can be found here:
> 
>     https://lore.kernel.org/r/20200821002424.119492231@linutronix.de
> 
> It's still a mixed bag of bug fixes, cleanups and general improvements
> which are worthwhile independent of device MSI.

Reverting the part of this patchset on the top of today's linux-next fixed an
boot issue on HPE ProLiant DL560 Gen10, i.e.,

$ git revert --no-edit 13b90cadfc29..bc95fd0d7c42

.config: https://gitlab.com/cailca/linux-mm/-/blob/master/x86.config

It looks like the crashes happen in the interrupt remapping code where they are
only able to to generate partial call traces.

[    1.912386][    T0] ACPI: X2APIC_NMI (uid[0xf5] high level 9983][    T0] ... MAX_LOCK_DEPTH:          48
[    7.914876][    T0] ... MAX_LOCKDEP_KEYS:        8192
[    7.919942][    T0] ... CLASSHASH_SIZE:          4096
[    7.925009][    T0] ... MAX_LOCKDEP_ENTRIES:     32768
[    7.930163][    T0] ... MAX_LOCKDEP_CHAINS:      65536
[    7.935318][    T0] ... CHAINHASH_SIZE:          32768
[    7.940473][    T0]  memory used by lock dependency info: 6301 kB
[    7.946586][    T0]  memory used for stack traces: 4224 kB
[    7.952088][    T0]  per task-struct memory footprint: 1920 bytes
[    7.968312][    T0] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    7.980281][    T0] ACPI: Core revision 20200717
[    7.993343][    T0] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    8.003270][    T0] APIC: Switch to symmetric I/O mode setup
[    8.008951][    T0] DMAR: Host address width 46
[    8.013512][    T0] DMAR: DRHD base: 0x000000e5ffc000 flags: 0x0
[    8.019680][    T0] DMAR: dmar0: reg_base_addr e5ffc000 ver 1:0 cap 8d2078c106f0466 [    T0] DMAR-IR: IOAPIC id 15 under DRHD base  0xe5ffc000 IOMMU 0
[    8.420990][    T0] DMAR-IR: IOAPIC id 8 under DRHD base  0xddffc000 IOMMU 15
[    8.428166][    T0] DMAR-IR: IOAPIC id 9 under DRHD base  0xddffc000 IOMMU 15
[    8.435341][    T0] DMAR-IR: HPET id 0 under DRHD base 0xddffc000
[    8.441456][    T0] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    8.457911][    T0] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    8.466614][    T0] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    8.474295][    T0] #PF: supervisor instruction fetch in kernel mode
[    8.480669][    T0] #PF: error_code(0x0010) - not-present page
[    8.486518][    T0] PGD 0 P4D 0 
[    8.489757][    T0] Oops: 0010 [#1] SMP KASAN PTI
[    8.494476][    T0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G          I       5.9.0-rc6-next-20200925 #2
[    8.503987][    T0] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10, BIOS U34 11/13/2019
[    8.513238][    T0] RIP: 0010:0x0
[    8.516562][    T0] Code: Bad RIP v

or

[    2.906744][    T0] ACPI: X2API32, address 0xfec68000, GSI 128-135
[    2.907063][    T0] IOAPIC[15]: apic_id 29, version 32, address 0xfec70000, GSI 136-143
[    2.907071][    T0] IOAPIC[16]: apic_id 30, version 32, address 0xfec78000, GSI 144-151
[    2.907079][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    2.907084][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    2.907100][    T0] Using ACPI (MADT) for SMP configuration information
[    2.907105][    T0] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    2.907116][    T0] ACPI: SPCR: console: uart,mmio,0x0,115200
[    2.907121][    T0] TSC deadline timer available
[    2.907126][    T0] smpboot: Allowing 144 CPUs, 0 hotplug CPUs
[    2.907163][    T0] [mem 0xd0000000-0xfdffffff] available for PCI devices
[    2.907175][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    2.914541][    T0] setup_percpu: NR_CPUS:256 nr_cpumask_bits:144 nr_cpu_ids:144 nr_node_ids:4
[    2.926109][   466 ecap f020df
[    9.134709][    T0] DMAR: DRHD base: 0x000000f5ffc000 flags: 0x0
[    9.140867][    T0] DMAR: dmar8: reg_base_addr f5ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    9.149610][    T0] DMAR: DRHD base: 0x000000f7ffc000 flags: 0x0
[    9.155762][    T0] DMAR: dmar9: reg_base_addr f7ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    9.164491][    T0] DMAR: DRHD base: 0x000000f9ffc000 flags: 0x0
[    9.170645][    T0] DMAR: dmar10: reg_base_addr f9ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    9.179476][    T0] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    9.185626][    T0] DMAR: dmar11: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    9.194442][    T0] DMAR: DRHD base: 0x000000dfffc000 flags: 0x0
[    9.200587][    T0] DMAR: dmar12: reg_base_addr dfffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    9.209418][    T0] DMAR: DRHD base: 0x000000e1ffc000 flags: 0x0
[    9.215551][    T0] DMAR: dmar13: reg_base_addr e1ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    9.224367][    T0] DMAR: DRHD base: 0x000000e3ffc83][    T0]  msi_domain_alloc+0x8e/0x280
[    9.615015][    T0]  __irq_domain_a8992cd
[    9.711906][    T0] R10: ffffffff85407d78 R11: fffffbfff18992cc R12: ffffffff8546ffc0
[    9.719761][    T0] R13: 0000000000000098 R14: ffff888106e63a40 R15: 0000000000000001
[    9.727617][    T0] FS:  0000000000000000(0000) GS:ffff8887df800000(0000) knlGS:0000000000000000
[    9.736431][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.742892][    T0] CR2: ffffffffffffffd6 CR3: 0000001ba7814001 CR4: 00000000000606b0
[    9.750747][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    9.758601][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    9.766456][    T0] Kernel panic - not syncing: Fatal exception
[    9.772547][    T0] ---[ end Kernel panic - not syncing: Fatal exception ]---

The working boot (without those patches) looks like this:

[    1.913963][    T0] ACPI: X2APIC_NMI (uid[0xf4] high level lint[0x1])
[    1.913967][    T0] ACPI: X2APIC_NMI (uid[0xf5] high level lint[0x1])
[    1.913970][    T0] ACPI: X2APIC_NMI (uid[0xf6] high level lint[0x1])
[    1.913974][    T0] ACPI: X2APIC_NMI (uid[0xf7] high level lint[0x1])
[    1.914017][    T0] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    1.914032][    T0] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-31
[    1.914039][    T0] IOAPIC[2]: apic_id 10, version 32, address 0xfec08000, GSI 32-39
[    1.914047][    T0] IOAPIC[3]: apic_id 11, version 32, address 0xfec10000, GSI 40-47
[    1.914054][    T0] IOAPIC[4]: apic_id 12, version 32, address 0xfec18000, GSI 48-55
[    1.914062][    T0] IOAPIC[5]: apic_id 15, version 32, address 0xfec20000, GSI 56-63
[    1.[    7.994567][    T0] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    8.006541][    T0] ACPI: Core revision 20200717
[    8.019713][    T0] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    8.029672][    T0] APIC: Switch to symmetric I/O mode setup
[    8.035354][    T0] DMAR: Host address width 46
[    8.039915][    T0] DMAR: DRHD base: 0x000000e5ffc000 flags: 0x0
[    8.046095][    T0] DMAR: dmar0: reg_base_addr e5ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    8.054840][    T0] DMAR: DRHD base: 0x000000e7ffc000 flags: 0x0
[    8.060997][    T0] DMAR: dmar1: reg_base_addr e7ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    8.069740][    T0] DMAR: DRHD base: 0x000000e9ffc000 flags: 0x0
[    8.075872][    T0] DMAR: dmar2: reg_base_addr e9ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    8.084615][    T0] DMAR: DRHD base: 0x000000ebffc000 flags: 0x0
[    8.090761][    T0] DMAR: dmar3: reg_base_addr ebffc000 ver 1:0 cap 8d2078c106f0466 ecap fMAR-IR: Enabled IRQ remapping in x2apic mode
[    8.513491][    T0] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    8.568289][    T0] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
[    8.579576][    T0] Calibrating delay loop (skipped), value calculated using timer frequency.. 6000.00 BogoMIPS (lpj=30000000)
[    8.589574][    T0] pid_max: default: 147456 minimum: 1152
[    8.714025][    T0] efi: memattr: Entry attributes invalid: RO and XP bits both cleared
[    8.719577][    T0] efi: memattr: ! 0x0000a057a000-0x0000a05b4fff [Runtime Code       |RUN|  |  |  |  |  |  |  |   |  |  |  |  ]
[    8.775355][    T0] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, vmalloc)
[    8.798868][    T0] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, vmalloc)
[    8.811550][    T0] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, vmalloc)
[    8.820076][    T0] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, vmalloc)
[    8.879327][    T0] mce: CPU0: Thermal mo[    8.996916][    T1] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    8.999591][    T1] ... version:                4
[    9.004310][    T1] ... bit width:              48
[    9.009118][    T1] ... generic registers:      4
[    9.009574][    T1] ... value mask:             0000ffffffffffff
[    9.015601][    T1] ... max period:             00007fffffffffff
[    9.019574][    T1] ... fixed-purpose events:   3
[    9.024294][    T1] ... event mask:             000000070000000f
[    9.034357][    T1] rcu: Hierarchical SRCU implementation.
[    9.062516][    T5] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.

> 
> There are quite a bunch of issues to solve:
> 
>   - X86 does not use the device::msi_domain pointer for historical reasons
>     and due to XEN, which makes it impossible to create an architecture
>     agnostic device MSI infrastructure.
> 
>   - X86 has it's own msi_alloc_info data type which is pointlessly
>     different from the generic version and does not allow to share code.
> 
>   - The logic of composing MSI messages in an hierarchy is busted at the
>     core level and of course some (x86) drivers depend on that.
> 
>   - A few minor shortcomings as usual
> 
> This series addresses that in several steps:
> 
>  1) Accidental bug fixes
> 
>       iommu/amd: Prevent NULL pointer dereference
> 
>  2) Janitoring
> 
>       x86/init: Remove unused init ops
>       PCI: vmd: Dont abuse vector irqomain as parent
>       x86/msi: Remove pointless vcpu_affinity callback
> 
>  3) Sanitizing the composition of MSI messages in a hierarchy
>  
>       genirq/chip: Use the first chip in irq_chip_compose_msi_msg()
>       x86/msi: Move compose message callback where it belongs
> 
>  4) Simplification of the x86 specific interrupt allocation mechanism
> 
>       x86/irq: Rename X86_IRQ_ALLOC_TYPE_MSI* to reflect PCI dependency
>       x86/irq: Add allocation type for parent domain retrieval
>       iommu/vt-d: Consolidate irq domain getter
>       iommu/amd: Consolidate irq domain getter
>       iommu/irq_remapping: Consolidate irq domain lookup
> 
>  5) Consolidation of the X86 specific interrupt allocation mechanism to be as
> close
>     as possible to the generic MSI allocation mechanism which allows to get
> rid
>     of quite a bunch of x86'isms which are pointless
> 
>       x86/irq: Prepare consolidation of irq_alloc_info
>       x86/msi: Consolidate HPET allocation
>       x86/ioapic: Consolidate IOAPIC allocation
>       x86/irq: Consolidate DMAR irq allocation
>       x86/irq: Consolidate UV domain allocation
>       PCI/MSI: Rework pci_msi_domain_calc_hwirq()
>       x86/msi: Consolidate MSI allocation
>       x86/msi: Use generic MSI domain ops
> 
>   6) x86 specific cleanups to remove the dependency on arch_*_msi_irqs()
> 
>       x86/irq: Move apic_post_init() invocation to one place
>       x86/pci: Reducde #ifdeffery in PCI init code
>       x86/irq: Initialize PCI/MSI domain at PCI init time
>       irqdomain/msi: Provide DOMAIN_BUS_VMD_MSI
>       PCI: vmd: Mark VMD irqdomain with DOMAIN_BUS_VMD_MSI
>       PCI/MSI: Provide pci_dev_has_special_msi_domain() helper
>       x86/xen: Make xen_msi_init() static and rename it to xen_hvm_msi_init()
>       x86/xen: Rework MSI teardown
>       x86/xen: Consolidate XEN-MSI init
>       irqdomain/msi: Allow to override msi_domain_alloc/free_irqs()
>       x86/xen: Wrap XEN MSI management into irqdomain
>       iommm/vt-d: Store irq domain in struct device
>       iommm/amd: Store irq domain in struct device
>       x86/pci: Set default irq domain in pcibios_add_device()
>       PCI/MSI: Make arch_.*_msi_irq[s] fallbacks selectable
>       x86/irq: Cleanup the arch_*_msi_irqs() leftovers
>       x86/irq: Make most MSI ops XEN private
>       iommu/vt-d: Remove domain search for PCI/MSI[X]
>       iommu/amd: Remove domain search for PCI/MSI
> 
>   7) X86 specific preparation for device MSI
> 
>       x86/irq: Add DEV_MSI allocation type
>       x86/msi: Rename and rework pci_msi_prepare() to cover non-PCI MSI
> 
>   8) Generic device MSI infrastructure
>       platform-msi: Provide default irq_chip:: Ack
>       genirq/proc: Take buslock on affinity write
>       genirq/msi: Provide and use msi_domain_set_default_info_flags()
>       platform-msi: Add device MSI infrastructure
>       irqdomain/msi: Provide msi_alloc/free_store() callbacks
> 
>   9) POC of IMS (Interrupt Message Storm) irq domain and irqchip
>      implementations for both device array and queue storage.
> 
>       irqchip: Add IMS (Interrupt Message Storm) driver - NOT FOR MERGING
> 
> Changes vs. V1:
> 
>    - Addressed various review comments and addressed the 0day fallout.
>      - Corrected the XEN logic (Jürgen)
>      - Make the arch fallback in PCI/MSI opt-in not opt-out (Bjorn)
> 
>    - Fixed the compose MSI message inconsistency
> 
>    - Ensure that the necessary flags are set for device SMI
> 
>    - Make the irq bus logic work for affinity setting to prepare
>      support for IMS storage in queue memory. It turned out to be
>      less scary than I feared.
> 
>    - Remove leftovers in iommu/intel|amd
> 
>    - Reworked the IMS POC driver to cover queue storage so Jason can have a
>      look whether that fits the needs of MLX devices.
> 
> The whole lot is also available from git:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git device-msi
> 
> This has been tested on Intel/AMD/KVM but lacks testing on:
> 
>     - HYPERV (-ENODEV)
>     - VMD enabled systems (-ENODEV)
>     - XEN (-ENOCLUE)
>     - IMS (-ENODEV)
> 
>     - Any non-X86 code which might depend on the broken compose MSI message
>       logic. Marc excpects not much fallout, but agrees that we need to fix
>       it anyway.
> 
> #1 - #3 should be applied unconditionally for obvious reasons
> #4 - #6 are wortwhile cleanups which should be done independent of device MSI
> 
> #7 - #8 look promising to cleanup the platform MSI implementation
>      	independent of #8, but I neither had cycles nor the stomach to
>      	tackle that.
> 
> #9	is obviously just for the folks interested in IMS
> 
> Thanks,
> 
> 	tglx

