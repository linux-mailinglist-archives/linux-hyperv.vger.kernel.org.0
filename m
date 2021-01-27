Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031F63052FB
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Jan 2021 07:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhA0GOe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 27 Jan 2021 01:14:34 -0500
Received: from mail-mw2nam10on2122.outbound.protection.outlook.com ([40.107.94.122]:56080
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232692AbhA0Frw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Jan 2021 00:47:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Abq3C/jG1fKYhV9/sXiwars//zxyOP2kHKLBr0z7HW6+vh3yN4oJGlWBtwQAqThdXPcSs+Bp/hWQqCLR0G+SSVXC17te/5h6M3gxVm5cSnVhtSIdSp9MUa+zSQP57qnZ7+YDSUb2dJT07mn3DtRfwfnsA/hR2wwUKiK9lq+5JfLwbRZA5Rvmi4U6HOjQBEVqpaHYefT4YNxejPUciCzrEiO0UnpD+/cBUoniZt6TQv+SqXGGQ4yF1hkaZEOUNkB6U4bTuyr5gUphRqMrZ6uYjD3uKeZid85LDR90gn9nBhE+YHWXufPWjZ7nNSm5WWb9Pm0i6G8Otv9JwWlLsrUN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ9z5X96EewKkfj7Wk7lxHDa9VSWI3z5dMotn8jnYMY=;
 b=U742e5NkrxnkblEaPXra62CQaSeaXXku/T4u1Acc1vTP6uP/sqwzZB/3iWN6KURMcioyIgSFvBl8JmHnH4AXLMpYUq1AUoe8gl+oFJtj40jh8W3S29vdnXAvcLg5Yl8Eq4kY6CcgQF2ApQ+GO/p8WWF0Of/ZIDQMQy1XwAhdoZhY/6vFgUzL7tyT9wOdJMl2wBGaXWPX9jjDRT8OBgoSsbjvAkBGpb58dH41RtqdKDtpq0Mp4rAh6ipwIZVLej4hste839RyP8lf38jodbL8h0yrdMQ9wXXe4/PjKbRRLxeWY9LGkDCeWw3GtRWZn1zhO3+zbbWV4DPu4J2j+/AWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ9z5X96EewKkfj7Wk7lxHDa9VSWI3z5dMotn8jnYMY=;
 b=KRKcHV8YBDpzJqnG+zBEiA4bJtK8N6d7yqLdN7kBmf/TTUal35w8Ywv0J8G5NHBa/vZSCnFUJHBhNbThc7B879OGo0FqWubZ637vk/ft+hyWuALeStCqqrwlxQDZ6k7r05mSq3fpbglP/m4Y7ceU+SDY9XkeVNZOO5p5vBZbjwY=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1987.namprd21.prod.outlook.com (2603:10b6:303:78::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.2; Wed, 27 Jan 2021 05:47:04 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Wed, 27 Jan 2021
 05:47:04 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v5 15/16] x86/hyperv: implement an MSI domain for root
 partition
Thread-Topic: [PATCH v5 15/16] x86/hyperv: implement an MSI domain for root
 partition
Thread-Index: AQHW7yP6HaVdmem27E2jxVVgXGHGnKo6+Dxg
Date:   Wed, 27 Jan 2021 05:47:04 +0000
Message-ID: <MWHPR21MB1593FFC6005966A3D9BEA3EFD7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-16-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-16-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-27T05:47:02Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a867e241-d853-41ae-a1dd-f1e6507754aa;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82b20901-dbb2-4b47-5814-08d8c286f9e2
x-ms-traffictypediagnostic: MW4PR21MB1987:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB19874D85D74818DA403082B6D7BB9@MW4PR21MB1987.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MA4MiQAXfSFZSC6Qk4OIwrdbTk6EEgLbl/OXFROr0JPiaZIrhzzdhWa5rzGEl30P9acSct2ILjyiVMGtKGsxAncSW9nflsFGqWwne2ysOyQushsc0aUPBXkVxy0uEd9OBeFpYet5Z0D3q+kyUz6higrUtaS/vdTWYnXsAwrf+V4B46Cv/FwOe3SruTQvj/eNvhbm7CTr7b0x9tVXrq55vC3DVnHTs0DT9giQ/0kRHNkO7ynFiadtJSMxP5H0+WNkHtg4EXIyDHLvZIJKQngOdihAYHKHWTDYdbCOxE75BsdLvSDduPMQXyYy2zfiHk3flIfc1gsQCG0G2V0KlnZCVw1hBuundQoioxNAl9RnGmGcjaqMCWLPIr4vsNGbjy6tELG/yAselcyLpMxZZ2IwwIIKHqxKNJ/OZplD5502MiPhNUxzGQqBJkox8isE4mR/Ch5GPD6CoEbYWgR+lDnWWIv1VM30mXrti4spuNbLinhs4Y4AwtQ3Pw+GjkK12eMv8j6fnMyszxKlrgLhzyIYTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(186003)(26005)(7696005)(2906002)(30864003)(8936002)(83380400001)(64756008)(55016002)(5660300002)(8676002)(6506007)(9686003)(10290500003)(478600001)(66946007)(33656002)(110136005)(52536014)(76116006)(86362001)(54906003)(71200400001)(8990500004)(4326008)(316002)(66476007)(66446008)(82950400001)(7416002)(66556008)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pYjNtKRZ9jswC08uH4tGMGJTyfW2BGULAxTPNxfVbF+e+2JoESEhXaOXdB+h?=
 =?us-ascii?Q?a7ppIKOmD/qDhHEzXsvyBmHWu4eXIRYP8NLk0PnVV2vtOqvfNH/wOc4bbS25?=
 =?us-ascii?Q?ZVPKGKIZxf6PD9uVonNsuYr90+Rfyp41sqsjK2m99cWwmkvSqRLBu8PxYpQc?=
 =?us-ascii?Q?2you/XZtcBHNSC1mq9tR9p+tB68GUxWRt9SjPeFMqqIEdxzzoZyreglW8W9M?=
 =?us-ascii?Q?H+Bc5GCOzeH5et0Wyo20YBxxBBTxDJyy7C0DW/aX6IpY7K7r2jnibUD56WlX?=
 =?us-ascii?Q?YGAODKBsjDe4U/ntP9M/NnveXsmXyU8RqDIKdQ4EAQJcbCTOIAZ4IvQ+QlCx?=
 =?us-ascii?Q?vNwtUThitEmp8qCbVEqA7jOLapI6i5mOmuZMLOtxVdkDeJZv7bskXZqv2WxZ?=
 =?us-ascii?Q?Sp/mqdbEUgDIpb0Uq+f3SvEXoukDNQvh7pMmwMTXaShbM76fjVLy+l+ZYJzD?=
 =?us-ascii?Q?SuSr7nYqZoTUNUdtEsVvaUpwLRtQ70Oc/oo+3qrqO124qW0Eq27q6RjbAPjY?=
 =?us-ascii?Q?Enrr1k3uG99Zr20uqhq/h0Y0iE+wazMSB0nDb/AXfkvC8Vhv3exeoTs3XGlP?=
 =?us-ascii?Q?jD/ZIE7XDKW1oQX+j7/mq59tDP46rlohMjwO1JdzrfIcfpcFP5l3rSeej/+J?=
 =?us-ascii?Q?GZ5dmYIrQso/9yrOtqaziyaeyHW/P2Vbt8PImGxxyKbFkAPy24Jk0FNR9937?=
 =?us-ascii?Q?gMdU96KdJxGJ2i1LAloZd9ypfFA3DlRYWgE17+KQICiJDGkKLu0NjuHPpQbu?=
 =?us-ascii?Q?VEbE+MX+dDJYyDnofgCgfQYLAihyJbL27IlwGq5JRa5w32vA62y4fPW6KeH7?=
 =?us-ascii?Q?OoAea83NlbKa2dYTqVkwYFgOv1jqTv0SZZsZpfLPAW7i6rg7y/IAc5f32Wws?=
 =?us-ascii?Q?/qKnSkW+YIEZrK0p8vQ6/ZcPLF8iYYksPgw2d3+6OLxac979A9+H2OrIk/ar?=
 =?us-ascii?Q?/tFZOlQQDuxwJMDA7Z9xEMedVilpiRqrsH5uLjSbPIaI2QxJTi8B3fE+7B/M?=
 =?us-ascii?Q?YOhxJQpIjH7FPoB0AUXGYTo1mJ3U+0HF9iAXC0wOqWQtG7sM61eB5pZms4/V?=
 =?us-ascii?Q?Epa0MrXJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b20901-dbb2-4b47-5814-08d8c286f9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 05:47:04.4583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMvLe51tPffI4LueOQzPBwngdnSpFQlCdsqHY33y6lDjMbXRe/WwMfWacaLBfRlilECWqXiznvr7DlyQEgl/kLi/wcUNeMTprtFlBqLQtpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1987
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 A=
M
>=20
> When Linux runs as the root partition on Microsoft Hypervisor, its
> interrupts are remapped.  Linux will need to explicitly map and unmap
> interrupts for hardware.
>=20
> Implement an MSI domain to issue the correct hypercalls. And initialize
> this irqdomain as the default MSI irq domain.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v4: Fix compilation issue when CONFIG_PCI_MSI is not set.
> v3: build irqdomain.o for 32bit as well.

I'm not clear on the intent for 32-bit builds.  Given that hv_proc.c is bui=
lt
only for 64-bit, I'm assuming running Linux in the root partition
is only functional for 64-bit builds.  So is the goal simply that 32-bit
builds will compile correctly?  Seems like maybe there should be
a CONFIG option for running Linux in the root partition, and that
option would force 64-bit.

> v2: This patch is simplified due to upstream changes.
> ---
>  arch/x86/hyperv/Makefile        |   2 +-
>  arch/x86/hyperv/hv_init.c       |   9 +
>  arch/x86/hyperv/irqdomain.c     | 332 ++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h |   2 +
>  4 files changed, 344 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/hyperv/irqdomain.c
>=20
> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> index 565358020921..48e2c51464e8 100644
> --- a/arch/x86/hyperv/Makefile
> +++ b/arch/x86/hyperv/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-y			:=3D hv_init.o mmu.o nested.o
> +obj-y			:=3D hv_init.o mmu.o nested.o irqdomain.o
>  obj-$(CONFIG_X86_64)	+=3D hv_apic.o hv_proc.o
>=20
>  ifdef CONFIG_X86_64
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index ad8e77859b32..1cb2f7d1850a 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -484,6 +484,15 @@ void __init hyperv_init(void)
>=20
>  	BUG_ON(hv_root_partition && hv_current_partition_id =3D=3D ~0ull);
>=20
> +#ifdef CONFIG_PCI_MSI
> +	/*
> +	 * If we're running as root, we want to create our own PCI MSI domain.
> +	 * We can't set this in hv_pci_init because that would be too late.
> +	 */
> +	if (hv_root_partition)
> +		x86_init.irqs.create_pci_msi_domain =3D hv_create_pci_msi_domain;
> +#endif
> +
>  	return;
>=20
>  remove_cpuhp_state:
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> new file mode 100644
> index 000000000000..19637cd60231
> --- /dev/null
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Irqdomain for Linux to run as the root partition on Microsoft Hypervi=
sor.
> +//
> +// Authors:
> +//   Sunil Muthuswamy <sunilmut@microsoft.com>
> +//   Wei Liu <wei.liu@kernel.org>

I think the // comment style should only be used for the SPDX line.

> +
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <asm/mshyperv.h>
> +
> +static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_ent=
ry)
> +{
> +	unsigned long flags;
> +	struct hv_input_unmap_device_interrupt *input;
> +	struct hv_interrupt_entry *intr_entry;
> +	u16 status;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +	intr_entry =3D &input->interrupt_entry;
> +	input->partition_id =3D hv_current_partition_id;
> +	input->device_id =3D id;
> +	*intr_entry =3D *old_entry;
> +
> +	status =3D hv_do_rep_hypercall(HVCALL_UNMAP_DEVICE_INTERRUPT, 0, 0, inp=
ut, NULL) &
> +			 HV_HYPERCALL_RESULT_MASK;
> +	local_irq_restore(flags);
> +
> +	return status;
> +}
> +
> +#ifdef CONFIG_PCI_MSI
> +struct rid_data {
> +	struct pci_dev *bridge;
> +	u32 rid;
> +};
> +
> +static int get_rid_cb(struct pci_dev *pdev, u16 alias, void *data)
> +{
> +	struct rid_data *rd =3D data;
> +	u8 bus =3D PCI_BUS_NUM(rd->rid);
> +
> +	if (pdev->bus->number !=3D bus || PCI_BUS_NUM(alias) !=3D bus) {
> +		rd->bridge =3D pdev;
> +		rd->rid =3D alias;
> +	}
> +
> +	return 0;
> +}
> +
> +static union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev)
> +{
> +	union hv_device_id dev_id;
> +	struct rid_data data =3D {
> +		.bridge =3D NULL,
> +		.rid =3D PCI_DEVID(dev->bus->number, dev->devfn)
> +	};
> +
> +	pci_for_each_dma_alias(dev, get_rid_cb, &data);
> +
> +	dev_id.as_uint64 =3D 0;
> +	dev_id.device_type =3D HV_DEVICE_TYPE_PCI;
> +	dev_id.pci.segment =3D pci_domain_nr(dev->bus);
> +
> +	dev_id.pci.bdf.bus =3D PCI_BUS_NUM(data.rid);
> +	dev_id.pci.bdf.device =3D PCI_SLOT(data.rid);
> +	dev_id.pci.bdf.function =3D PCI_FUNC(data.rid);
> +	dev_id.pci.source_shadow =3D HV_SOURCE_SHADOW_NONE;
> +
> +	if (data.bridge) {
> +		int pos;
> +
> +		/*
> +		 * Microsoft Hypervisor requires a bus range when the bridge is
> +		 * running in PCI-X mode.
> +		 *
> +		 * To distinguish conventional vs PCI-X bridge, we can check
> +		 * the bridge's PCI-X Secondary Status Register, Secondary Bus
> +		 * Mode and Frequency bits. See PCI Express to PCI/PCI-X Bridge
> +		 * Specification Revision 1.0 5.2.2.1.3.
> +		 *
> +		 * Value zero means it is in conventional mode, otherwise it is
> +		 * in PCI-X mode.
> +		 */
> +
> +		pos =3D pci_find_capability(data.bridge, PCI_CAP_ID_PCIX);
> +		if (pos) {
> +			u16 status;
> +
> +			pci_read_config_word(data.bridge, pos +
> +					PCI_X_BRIDGE_SSTATUS, &status);
> +
> +			if (status & PCI_X_SSTATUS_FREQ) {
> +				/* Non-zero, PCI-X mode */
> +				u8 sec_bus, sub_bus;
> +
> +				dev_id.pci.source_shadow =3D HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE;
> +
> +				pci_read_config_byte(data.bridge, PCI_SECONDARY_BUS, &sec_bus);
> +				dev_id.pci.shadow_bus_range.secondary_bus =3D sec_bus;
> +				pci_read_config_byte(data.bridge, PCI_SUBORDINATE_BUS, &sub_bus);
> +				dev_id.pci.shadow_bus_range.subordinate_bus =3D sub_bus;
> +			}
> +		}
> +	}
> +
> +	return dev_id;
> +}
> +
> +static int hv_map_msi_interrupt(struct pci_dev *dev, int vcpu, int vecto=
r,
> +				struct hv_interrupt_entry *entry)
> +{
> +	struct hv_input_map_device_interrupt *input;
> +	struct hv_output_map_device_interrupt *output;
> +	struct hv_device_interrupt_descriptor *intr_desc;
> +	unsigned long flags;
> +	u16 status;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	intr_desc =3D &input->interrupt_descriptor;
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D hv_current_partition_id;
> +	input->device_id =3D hv_build_pci_dev_id(dev).as_uint64;
> +	intr_desc->interrupt_type =3D HV_X64_INTERRUPT_TYPE_FIXED;
> +	intr_desc->trigger_mode =3D HV_INTERRUPT_TRIGGER_MODE_EDGE;
> +	intr_desc->vector_count =3D 1;
> +	intr_desc->target.vector =3D vector;
> +	__set_bit(vcpu, (unsigned long*)&intr_desc->target.vp_mask);

This is using the CPU bitmap format that supports up to 64 vCPUs.  Any reas=
on not
to use the format that supports a larger number of CPUs?   In either case, =
perhaps
a check for the value of vcpu against the max of 64 (or the larger number i=
f you
change the bitmap format) would be appropriate.

> +
> +	status =3D hv_do_rep_hypercall(HVCALL_MAP_DEVICE_INTERRUPT, 0, 0, input=
, output) &
> +			 HV_HYPERCALL_RESULT_MASK;
> +	*entry =3D output->interrupt_entry;
> +
> +	local_irq_restore(flags);
> +
> +	if (status !=3D HV_STATUS_SUCCESS)
> +		pr_err("%s: hypercall failed, status %d\n", __func__, status);
> +
> +	return status;
> +}
> +
> +static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, st=
ruct msi_msg *msg)
> +{
> +	/* High address is always 0 */
> +	msg->address_hi =3D 0;
> +	msg->address_lo =3D entry->msi_entry.address.as_uint32;
> +	msg->data =3D entry->msi_entry.data.as_uint32;
> +}
> +
> +static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interru=
pt_entry *old_entry);
> +static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg=
 *msg)
> +{
> +	struct msi_desc *msidesc;
> +	struct pci_dev *dev;
> +	struct hv_interrupt_entry out_entry, *stored_entry;
> +	struct irq_cfg *cfg =3D irqd_cfg(data);
> +	struct cpumask *affinity;
> +	int cpu, vcpu;
> +	u16 status;
> +
> +	msidesc =3D irq_data_get_msi_desc(data);
> +	dev =3D msi_desc_to_pci_dev(msidesc);
> +
> +	if (!cfg) {
> +		pr_debug("%s: cfg is NULL", __func__);
> +		return;
> +	}
> +
> +	affinity =3D irq_data_get_effective_affinity_mask(data);
> +	cpu =3D cpumask_first_and(affinity, cpu_online_mask);
> +	vcpu =3D hv_cpu_number_to_vp_number(cpu);
> +
> +	if (data->chip_data) {
> +		/*
> +		 * This interrupt is already mapped. Let's unmap first.
> +		 *
> +		 * We don't use retarget interrupt hypercalls here because
> +		 * Microsoft Hypervisor doens't allow root to change the vector
> +		 * or specify VPs outside of the set that is initially used
> +		 * during mapping.
> +		 */
> +		stored_entry =3D data->chip_data;
> +		data->chip_data =3D NULL;
> +
> +		status =3D hv_unmap_msi_interrupt(dev, stored_entry);
> +
> +		kfree(stored_entry);
> +
> +		if (status !=3D HV_STATUS_SUCCESS) {
> +			pr_debug("%s: failed to unmap, status %d", __func__, status);
> +			return;
> +		}
> +	}
> +
> +	stored_entry =3D kzalloc(sizeof(*stored_entry), GFP_ATOMIC);
> +	if (!stored_entry) {
> +		pr_debug("%s: failed to allocate chip data\n", __func__);
> +		return;
> +	}
> +
> +	status =3D hv_map_msi_interrupt(dev, vcpu, cfg->vector, &out_entry);
> +	if (status !=3D HV_STATUS_SUCCESS) {
> +		kfree(stored_entry);
> +		return;
> +	}
> +
> +	*stored_entry =3D out_entry;
> +	data->chip_data =3D stored_entry;
> +	entry_to_msi_msg(&out_entry, msg);
> +
> +	return;
> +}
> +
> +static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interru=
pt_entry
> *old_entry)
> +{
> +	return hv_unmap_interrupt(hv_build_pci_dev_id(dev).as_uint64, old_entry=
)
> +		& HV_HYPERCALL_RESULT_MASK;

The masking with HV_HYPERCALL_RESULT_MASK is already done in
hv_unmap_interrupt().

> +}
> +
> +static void hv_teardown_msi_irq_common(struct pci_dev *dev, struct msi_d=
esc
> *msidesc, int irq)
> +{
> +	u16 status;
> +	struct hv_interrupt_entry old_entry;
> +	struct irq_desc *desc;
> +	struct irq_data *data;
> +	struct msi_msg msg;
> +
> +	desc =3D irq_to_desc(irq);
> +	if (!desc) {
> +		pr_debug("%s: no irq desc\n", __func__);
> +		return;
> +	}
> +
> +	data =3D &desc->irq_data;
> +	if (!data) {
> +		pr_debug("%s: no irq data\n", __func__);
> +		return;
> +	}
> +
> +	if (!data->chip_data) {
> +		pr_debug("%s: no chip data\n!", __func__);
> +		return;
> +	}
> +
> +	old_entry =3D *(struct hv_interrupt_entry *)data->chip_data;
> +	entry_to_msi_msg(&old_entry, &msg);
> +
> +	kfree(data->chip_data);
> +	data->chip_data =3D NULL;
> +
> +	status =3D hv_unmap_msi_interrupt(dev, &old_entry);
> +
> +	if (status !=3D HV_STATUS_SUCCESS) {
> +		pr_err("%s: hypercall failed, status %d\n", __func__, status);
> +		return;
> +	}
> +}
> +
> +static void hv_msi_domain_free_irqs(struct irq_domain *domain, struct de=
vice *dev)
> +{
> +	int i;
> +	struct msi_desc *entry;
> +	struct pci_dev *pdev;
> +
> +	if (WARN_ON_ONCE(!dev_is_pci(dev)))
> +		return;
> +
> +	pdev =3D to_pci_dev(dev);
> +
> +	for_each_pci_msi_entry(entry, pdev) {
> +		if (entry->irq) {
> +			for (i =3D 0; i < entry->nvec_used; i++) {
> +				hv_teardown_msi_irq_common(pdev, entry, entry->irq +
> i);
> +				irq_domain_free_irqs(entry->irq + i, 1);
> +			}
> +		}
> +	}
> +}
> +
> +/*
> + * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
> + * which implement the MSI or MSI-X Capability Structure.
> + */
> +static struct irq_chip hv_pci_msi_controller =3D {
> +	.name			=3D "HV-PCI-MSI",
> +	.irq_unmask		=3D pci_msi_unmask_irq,
> +	.irq_mask		=3D pci_msi_mask_irq,
> +	.irq_ack		=3D irq_chip_ack_parent,
> +	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
> +	.irq_compose_msi_msg	=3D hv_irq_compose_msi_msg,
> +	.irq_set_affinity	=3D msi_domain_set_affinity,
> +	.flags			=3D IRQCHIP_SKIP_SET_WAKE,
> +};
> +
> +static struct msi_domain_ops pci_msi_domain_ops =3D {
> +	.domain_free_irqs	=3D hv_msi_domain_free_irqs,
> +	.msi_prepare		=3D pci_msi_prepare,
> +};
> +
> +static struct msi_domain_info hv_pci_msi_domain_info =3D {
> +	.flags		=3D MSI_FLAG_USE_DEF_DOM_OPS |
> MSI_FLAG_USE_DEF_CHIP_OPS |
> +			  MSI_FLAG_PCI_MSIX,
> +	.ops		=3D &pci_msi_domain_ops,
> +	.chip		=3D &hv_pci_msi_controller,
> +	.handler	=3D handle_edge_irq,
> +	.handler_name	=3D "edge",
> +};
> +
> +struct irq_domain * __init hv_create_pci_msi_domain(void)
> +{
> +	struct irq_domain *d =3D NULL;
> +	struct fwnode_handle *fn;
> +
> +	fn =3D irq_domain_alloc_named_fwnode("HV-PCI-MSI");
> +	if (fn)
> +		d =3D pci_msi_create_irq_domain(fn, &hv_pci_msi_domain_info,
> x86_vector_domain);
> +
> +	/* No point in going further if we can't get an irq domain */
> +	BUG_ON(!d);
> +
> +	return d;
> +}
> +
> +#endif /* CONFIG_PCI_MSI */
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index cbee72550a12..ccc849e25d5e 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -261,6 +261,8 @@ static inline void hv_set_msi_entry_from_desc(union h=
v_msi_entry
> *msi_entry,
>  	msi_entry->data.as_uint32 =3D msi_desc->msg.data;
>  }
>=20
> +struct irq_domain *hv_create_pci_msi_domain(void);
> +
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
>  static inline void hyperv_setup_mmu_ops(void) {}
> --
> 2.20.1

