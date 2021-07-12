Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43F13C6336
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jul 2021 21:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbhGLTK1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Jul 2021 15:10:27 -0400
Received: from mail-dm6nam10on2124.outbound.protection.outlook.com ([40.107.93.124]:56977
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236084AbhGLTK0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Jul 2021 15:10:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA6o5v0j72FssvdXRBtI6vWwCbFIvSpyDm0/ZUURytlb6XUtXNTLasAyAvpFW4K3a0hLSH9M0gn3rjDzzdBKO3N4GBu4sKuc8pyFG3o58qQMqIKyXOiGLxdpJlP4aa7Tu3xfPGdLaopleD5xfP4pB8YSC3o/vAgOYW3jl7+NhFf2igzgfHghb+T0oH3otyIAhEGt8dmi+RPdxUQh/IChWt/j8qU5zmJqkTPb/Dyu+uSRs1Aae6OKzoZYJECD3xKRr+OuQV10fgxOarSH+GR4HkLyTJBl2fV/qwwZmFkhuN9OXRCZ76yZc5FNtlqgFW+lIYbIMkLU+JLd2r/0ixZtIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUM4+fOzUo0gG6HGAHhmyVjLZVEIdcyvVFOloslkBnU=;
 b=JHzi1ZQrtQa6nAPBVFS72kfYN72WBsDkOtfcL3wqj8l6QYqPBdMw51WjDLF57/hEfgtfIYK8fpJrJRWetpKrJTQWv1qBuWOZ9AFN1i/NBN61ljk+sc6+q+GMoGzBrBcUo7KHaRj+efmvS3smYbOfeCOHrWgjTrW+n1xo7CKr5CLt62qZRQBW3lZs0s5E4jdLMg1jExwH0/YzzKbUpFSie+36MUUGa/f9pPFpLFsVxtjtAXdZdyE8hmOKE4/Igl930q6KYhT17bvWO7zjaE+qhNX5IiPsdoacal5gRofphCn365/2X2vRh2wJ3ll5+STGihZgUU1rF6jFrUCiiyotjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUM4+fOzUo0gG6HGAHhmyVjLZVEIdcyvVFOloslkBnU=;
 b=OUJH+RrTQP6ecoduOYT3KrUz08XQgOkDdB7xQh8v0XsHGDy938X82LPbYBCZ1Kp7myZJjl9oGBgjjeo0dtXflHiNsZ6io5nY32ya5s+5iyP+iD+Q5heTbmB6CeSEXh/7xqo1bZqnADJ8ZDIYISzvzf7x0kYOXhq6i7el1oor7LE=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB2025.namprd21.prod.outlook.com (2603:10b6:303:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.8; Mon, 12 Jul
 2021 19:07:35 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19%7]) with mapi id 15.20.4331.009; Mon, 12 Jul 2021
 19:07:35 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>, Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH 1/1] PCI: hv: Support for create interrupt v3
Thread-Topic: [PATCH 1/1] PCI: hv: Support for create interrupt v3
Thread-Index: Add0TIVdcQX5pMV/TWWUfz5smDdQ7ADAscqQ
Date:   Mon, 12 Jul 2021 19:07:35 +0000
Message-ID: <MWHPR21MB15933F3AB6C53B11B0257E11D7159@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <MW4PR21MB20025B945D77BBFDF61C6DA8C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
In-Reply-To: <MW4PR21MB20025B945D77BBFDF61C6DA8C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0427ad34-30ce-4617-8641-271adbc45791;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-12T18:54:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a10589c-042b-4cd7-55c2-08d945684f03
x-ms-traffictypediagnostic: MW4PR21MB2025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB2025EADDFA199F84F298FF25D7159@MW4PR21MB2025.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H99wOylYBpJ4fVhOGQTNjlGjlQiB81QurpU0Vfl50eUZMWR4txiXwnwV2bi5txIGLirSsObRLFAq19BqpIlYH6psLb+qQRD7mmjs9s8dkwkdSs/yqDnPmNwc0LVRObeMPCwfEusB7aLGL2nNT74W5F7+b7ZzOhQ9IjoTgGcn+2msA7HHMhPlZDSs+f9JdIulZI52sXv5obhW3qG5UQRw6tJF0TkS8S3Q9MJsGBKEHZZ8OQBXK84Bp+qvQDxxsH8nyOU9f2aj8E9wIGrPU8e6yrctIYx5QEurULuj1OWQsSSYZgv1gBnx8C4QYfK0LrypSlc+If3oPlyWKnyit6zlw4V8itFv++1pCcwNzMrHV1v8gMslvovokf5EAmhys65Ovberl5haZYgSKmyexoRpDNvz249LbMggvWwWWu74hABDWwQVNCK26U65V8mlGxDzQvz/XhJNL50JrH7kgUDJgD7XMGkiibvtvpq2PEytLYI0WYOSr7w+EYQcjSiGlnkpC/JkwVJ4yYPN9gbpJim79h7P0XniGKsOWgN6+RF7Op4dgaV+ggiMT0sRA5hwdaatrC30QgOco7QnVmmhptHHXvY25RknlFA76wcTpG5/hIDWVEPRK8ZhzfX7yBtVR7xxw7EXQz9pC1dCLM9/CnzOKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(82950400001)(4326008)(5660300002)(64756008)(10290500003)(52536014)(55016002)(82960400001)(66476007)(66556008)(8990500004)(66446008)(76116006)(71200400001)(66946007)(6636002)(26005)(478600001)(6506007)(7696005)(122000001)(8936002)(8676002)(38100700002)(316002)(83380400001)(110136005)(2906002)(33656002)(186003)(86362001)(9686003)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RibO4lp/D389fTJ5eQd0pMTRyVqJhIxH8fZH5Vxb25uLgKrYfgDvP1vH53/w?=
 =?us-ascii?Q?iyBXCkDh0EIHhoaZ8kxjXry31Mafd/FyhZw/EMsjm20CtRwvTp3iEswkil6D?=
 =?us-ascii?Q?jcTTA6uPSF8xrM8oCAxC1Eyg88iFA2cypkuK4/0k6K/8gMCZWeHfNtwjI9nT?=
 =?us-ascii?Q?7aunJZRJftvZNki6H5VsA718UdzM78844wSpt5/BbWoSr/rF5gCvhhNAb4r/?=
 =?us-ascii?Q?WO2RB7XaTxQ/QH0cuEoTWqojMyGB+F5/zi1tmwffbyVUPBH6VdCJzOMTkLBt?=
 =?us-ascii?Q?ibuf5ymzUzdl5VxIn2Ofzw0a5cwY1tJALVIP9iWlHdpsMa9oR7ToN1A87D4k?=
 =?us-ascii?Q?zETv/egc5CxAUpnPSZUuo5A4yKKKEsgbQpU2+Tjd7UanLu1gKcITemI5NVhK?=
 =?us-ascii?Q?rkhNbsGD5gUed7eLpFhRLutpC/TAjjkbDaDppqotlSn/mh4t5uRmNu2Ac3z2?=
 =?us-ascii?Q?FgkwYovdyKIWduBD2R1xh5Ekcz293xy+S4mtgYTtiiLF7q8iFXisWSQmHDFQ?=
 =?us-ascii?Q?2Vi2D3rym/kqRR43OlfL3OLGnhGBDc3wJ1dxmP+kSlB+0YL6pnR+QQaAHjG+?=
 =?us-ascii?Q?e8xuxvRvOLJJC1riez3hW9RjJD3wUkvTtJSUWQ+mEM7FW7FRqAm2jgkRyCjR?=
 =?us-ascii?Q?ICvvJkkn1nVvXSuKMK+/uIAkWRpoKEtnz+QPpSBEh3t9TOa5joVKUahJyTvj?=
 =?us-ascii?Q?bw73MQvDBY6T1v4hQY6+GsgpkAbq1O6ynml7N7f3S06WtdSoCCPEHT3NEWUO?=
 =?us-ascii?Q?QNtleEWnQz1D7Zu+1H/ZYRgcaynS1O+h5r9RRT8T8zDZ6b7VW1axZTVL+YPk?=
 =?us-ascii?Q?IACkWPh+T2r4JSNbwvuF3okHua1+b7Za/JicZ83xhZR0ZIFrzq64dFqVDSgY?=
 =?us-ascii?Q?4bIQZGAyGE2vd2+fHo4KJmF4frMK1hLV1dJgFY103Kb0tsjEY3jq7HpM8TEv?=
 =?us-ascii?Q?MnGITzcF7Tb6mqUyFcG2UXGqnnNnbmMDL2Ulq2fxQ74KthtdkEesCN4+3Q28?=
 =?us-ascii?Q?o2xo2KH+tV9q5icZxPUOqo4orBjZNVJRyYF6ZzJ9qZ5L8S4VYf23QakTPbTE?=
 =?us-ascii?Q?PV2+L4uSra3JMgQ9+cLROr914rMHpM1l8greUsEPLYGG0Dy2c43A0TbTkmqr?=
 =?us-ascii?Q?0bzSzZ1Pqtt+70x6BgpyFfBwy1m8rHw6BnNhftatsgKVOpiCIYzRfYd8iSqe?=
 =?us-ascii?Q?fpW9UwHrMqIKmWjy9nqbyUpctdVjdfYhJ7GnN557CG3RZYJ7FkueKcEr1RSe?=
 =?us-ascii?Q?gMbpXlqhnFMrLYVREXz0fam+0LwTSNGMx5u92s4KHeToL9XfKJySDLh7UDi4?=
 =?us-ascii?Q?HBTX08a5y2M9x9RDvvfpJ4t+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a10589c-042b-4cd7-55c2-08d945684f03
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 19:07:35.2700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9xmWLS1O/8Xco7xHpJDwyYD+IZq61ImGpkF/iXpTi3nOweDVQW+ss2qaB49iO2d5V7UgRXRrcXk6qZypmOAQmT4hDt7bbDDoH4+EUJHXtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2025
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com> Sent: Thursday, July 8, 202=
1 4:05 PM
>=20
> Hyper-V vPCI protocol version 1_4 adds support for create interrupt
> v3. Create interrupt v3 essentially makes the size of the vector
> field bigger in the message, thereby allowing bigger vector values.
> For example, that will come into play for supporting LPI vectors
> on ARM, which start at 8192.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 74 ++++++++++++++++++++++++++---
>  1 file changed, 68 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index bebe3eeebc4e..de61b20f9604 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -64,6 +64,7 @@ enum pci_protocol_version_t {
>  	PCI_PROTOCOL_VERSION_1_1 =3D PCI_MAKE_VERSION(1, 1),	/* Win10 */
>  	PCI_PROTOCOL_VERSION_1_2 =3D PCI_MAKE_VERSION(1, 2),	/* RS1 */
>  	PCI_PROTOCOL_VERSION_1_3 =3D PCI_MAKE_VERSION(1, 3),	/* Vibranium */
> +	PCI_PROTOCOL_VERSION_1_4 =3D PCI_MAKE_VERSION(1, 4),      /* Fe */

It would be better if we can avoid annotating with internal code names.
Inside of MSFT we tend to forget over time, and people outside usually
have no idea what they mean. =20

>  };
>=20
>  #define CPU_AFFINITY_ALL	-1ULL
> @@ -73,6 +74,7 @@ enum pci_protocol_version_t {
>   * first.
>   */
>  static enum pci_protocol_version_t pci_protocol_versions[] =3D {
> +	PCI_PROTOCOL_VERSION_1_4,
>  	PCI_PROTOCOL_VERSION_1_3,
>  	PCI_PROTOCOL_VERSION_1_2,
>  	PCI_PROTOCOL_VERSION_1_1,
> @@ -122,6 +124,8 @@ enum pci_message_type {
>  	PCI_CREATE_INTERRUPT_MESSAGE2	=3D PCI_MESSAGE_BASE + 0x17,
>  	PCI_DELETE_INTERRUPT_MESSAGE2	=3D PCI_MESSAGE_BASE + 0x18, /* unused */
>  	PCI_BUS_RELATIONS2		=3D PCI_MESSAGE_BASE + 0x19,
> +	PCI_RESOURCES_ASSIGNED3         =3D PCI_MESSAGE_BASE + 0x1A,
> +	PCI_CREATE_INTERRUPT_MESSAGE3   =3D PCI_MESSAGE_BASE + 0x1B,
>  	PCI_MESSAGE_MAXIMUM
>  };
>=20
> @@ -235,6 +239,21 @@ struct hv_msi_desc2 {
>  	u16	processor_array[32];
>  } __packed;
>=20
> +/*
> + * struct hv_msi_desc3 - 1.3 version of hv_msi_desc
> + *	Everything is the same as in 'hv_msi_desc2' except that the size
> + *	of the 'vector_count' field is larger to support bigger vector

Actually, it's the "vector" field that's bigger, not "vector_count".

> + *	values. For ex: LPI vectors on ARM.
> + */
> +struct hv_msi_desc3 {
> +	u32	vector;
> +	u8	delivery_mode;
> +	u8	reserved;
> +	u16	vector_count;
> +	u16	processor_count;
> +	u16	processor_array[32];
> +} __packed;
> +
>  /**
>   * struct tran_int_desc
>   * @reserved:		unused, padding
> @@ -383,6 +402,12 @@ struct pci_create_interrupt2 {
>  	struct hv_msi_desc2 int_desc;
>  } __packed;
>=20
> +struct pci_create_interrupt3 {
> +	struct pci_message message_type;
> +	union win_slot_encoding wslot;
> +	struct hv_msi_desc3 int_desc;
> +} __packed;
> +
>  struct pci_delete_interrupt {
>  	struct pci_message message_type;
>  	union win_slot_encoding wslot;
> @@ -1334,26 +1359,55 @@ static u32 hv_compose_msi_req_v1(
>  	return sizeof(*int_pkt);
>  }
>=20
> +static void hv_compose_msi_req_get_cpu(struct cpumask *affinity, int *cp=
u,
> +				       u16 *count)
> +{
> +	/*
> +	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
> +	 * by subsequent retarget in hv_irq_unmask().
> +	 */
> +	*cpu =3D cpumask_first_and(affinity, cpu_online_mask);
> +	*count =3D 1;
> +}
> +
>  static u32 hv_compose_msi_req_v2(
>  	struct pci_create_interrupt2 *int_pkt, struct cpumask *affinity,
>  	u32 slot, u8 vector)
>  {
>  	int cpu;
> +	u16 cpu_count;
>=20
>  	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE2;
>  	int_pkt->wslot.slot =3D slot;
>  	int_pkt->int_desc.vector =3D vector;
>  	int_pkt->int_desc.vector_count =3D 1;
>  	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
> -
> -	/*
> -	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
> -	 * by subsequent retarget in hv_irq_unmask().
> -	 */
>  	cpu =3D cpumask_first_and(affinity, cpu_online_mask);

Shouldn't this line be deleted since the new hv_compose_msi_req_get_cpu()
function is doing the work?

> +	hv_compose_msi_req_get_cpu(affinity, &cpu, &cpu_count);
>  	int_pkt->int_desc.processor_array[0] =3D
>  		hv_cpu_number_to_vp_number(cpu);
> -	int_pkt->int_desc.processor_count =3D 1;
> +	int_pkt->int_desc.processor_count =3D cpu_count;
> +
> +	return sizeof(*int_pkt);
> +}
> +
> +static u32 hv_compose_msi_req_v3(
> +	struct pci_create_interrupt3 *int_pkt, struct cpumask *affinity,
> +	u32 slot, u32 vector)
> +{
> +	int cpu;
> +	u16 cpu_count;
> +
> +	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE3;
> +	int_pkt->wslot.slot =3D slot;
> +	int_pkt->int_desc.vector =3D vector;
> +	int_pkt->int_desc.reserved =3D 0;
> +	int_pkt->int_desc.vector_count =3D 1;
> +	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
> +	hv_compose_msi_req_get_cpu(affinity, &cpu, &cpu_count);
> +	int_pkt->int_desc.processor_array[0] =3D
> +		hv_cpu_number_to_vp_number(cpu);
> +	int_pkt->int_desc.processor_count =3D cpu_count;
>=20
>  	return sizeof(*int_pkt);
>  }
> @@ -1385,6 +1439,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a, struct msi_msg *msg)
>  		union {
>  			struct pci_create_interrupt v1;
>  			struct pci_create_interrupt2 v2;
> +			struct pci_create_interrupt3 v3;
>  		} int_pkts;
>  	} __packed ctxt;
>=20
> @@ -1432,6 +1487,13 @@ static void hv_compose_msi_msg(struct irq_data *da=
ta, struct msi_msg *msg)
>  					cfg->vector);
>  		break;
>=20
> +	case PCI_PROTOCOL_VERSION_1_4:
> +		size =3D hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
> +					dest,
> +					hpdev->desc.win_slot.slot,
> +					cfg->vector);
> +		break;
> +
>  	default:
>  		/* As we only negotiate protocol versions known to this driver,
>  		 * this path should never hit. However, this is it not a hot
> --
> 2.17.1
