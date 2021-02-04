Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A3830FBD6
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Feb 2021 19:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbhBDSn4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Feb 2021 13:43:56 -0500
Received: from mail-bn8nam11on2120.outbound.protection.outlook.com ([40.107.236.120]:41441
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239274AbhBDSlr (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Feb 2021 13:41:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7Z5MkxyPiHgLgIC4PQAHvezCWW7sl3lAqvJRftfZZtamx+tgfTiNFfq90U4JivIhBn85ir1gIirZVevwujLyI2VuyLG9vyYiplDP/9gL0qjyApHTdqLIgaBudLBtRcEo+ZP4TZx+QxYXIKULDySsKR7muyvQelmABTa/ANouysebilEu5mWB3hwsOJE1h0DYNOLW/TOu5Ais034efuaDAuCj5n9bdwc3zCICUZCiglAz9qhwo42MdRfjuapms2iB+jZoiaFWahBbaUS9UVpdGomfeEklrTut6mOMSrXhu9B7JwyUt8eu4Ri2kKp1yE5MFVwjP4G6kMNeRSvMh32yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRXjisDPWgYI/0nBK3VGaCpcqkuMTYkPZTXg6S6cuy4=;
 b=ffUB6ZpMo4+mem/QAYHnC1Wn4hbsTpBy1duft6BDxueBKH7TQbsPmA0h79wMSRPqurQbav6xyb9L5WIwFatnFaNVykcMFMH3+gAnfmsAj+Mr0XK5YVrFyAKOFk/TOj+/c1FF/snr3vSqKTPS7fmkCMvOgPB4GyMn7j/3mJRDxcLbY3i6P3t7Y6cpY/RPt2L/3PfWMZZG2wJI5lH+ovsMAm2dkyZ8Z0nWIeHEgkZHPpIADuCMY5fNFC5N8xFafzoT6B0wCKgi54ahi3fEmWzcNrZyhs4fCtdcbS9i6DVrEexp8woagBjK/TeEonsFU4wfAvxDJCaZjjRVSUsDH4oxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRXjisDPWgYI/0nBK3VGaCpcqkuMTYkPZTXg6S6cuy4=;
 b=f7BygmYTlyUvZldq72JuqJn9UZY64ahrdGdgyyN6rojdl/AZrflDFmAUTS6DGKenpPUvN3y/lSyRFrSn9zdbujIEkCTWw5dWrSRbCY67cAPHi24cpWr+EedF4wmzskdipspf9t5xP7Sh2JfRNTIlmfpnVtTq41HSJOhJaff8fCY=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB0478.namprd21.prod.outlook.com (2603:10b6:300:ec::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.4; Thu, 4 Feb 2021 18:40:55 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 18:40:55 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
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
Subject: RE: [PATCH v6 15/16] x86/hyperv: implement an MSI domain for root
 partition
Thread-Topic: [PATCH v6 15/16] x86/hyperv: implement an MSI domain for root
 partition
Thread-Index: AQHW+j3xAalli8BY20CIoxf429V3G6pIPvGwgAAKwoCAAArKkA==
Date:   Thu, 4 Feb 2021 18:40:55 +0000
Message-ID: <MWHPR21MB15934AD184476EF14CF4C732D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-16-wei.liu@kernel.org>
 <MWHPR21MB15932010E9CF5975EBAD1EDAD7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210204175641.pzonxqrqlo7uvvze@liuwe-devbox-debian-v2>
In-Reply-To: <20210204175641.pzonxqrqlo7uvvze@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T18:40:53Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bb9288e0-c62a-4f9b-96fb-f3b2506ec38f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28c569ea-82fa-4a45-8b09-08d8c93c67f6
x-ms-traffictypediagnostic: MWHPR21MB0478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0478D422D7F7A7DC5A77060CD7B39@MWHPR21MB0478.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYFnN/1gRLKhxrb1ZOYt14EWTeA3WEviQpXhvt/DgrAE5CLmZfsvoKhQdy6C2UzsMJFhPhoIxWvjfot+TKvwtHNUYKQvnV3+xCMvv0YZ2PB6oqF2kPrGdIHRb5qW9r/4bWhzWD9UUk3pvjIGSAAuH+a4eqIL4cL7eq/HSvJ/Q/1tAsP8lqMeetUr7XSxLy9ZSK2Velf8Q9jraPElqMG2L/xpAhz788ih9+yiitPpuoWrNU0jugesK+LXjTWaJYOnxFChGdJLxvw/6DDmuHZbg86MIhRbPaMklUfD9GBXfbMuvVcVeWa1KOp93AdDHdjI8p5oZO3oukbPWGgWjcFogLIR0CFFJHW2tqvBmtiTFW09G3ZJYOW6mUtlQ8dkMXxZ8cj920tOpZNJZgWqFyXMrz9qtAVOBvpXzmgSu13eBD7aFuPp7oyUBPlYis4BsTY4bvpoijFatfTSxDz7/DfKk9QUhn4zt7rp8n6dXTD+56S2lYpYtwxt8o57mtJWDadix5WQct2GIIIu/9tWzCbhLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(478600001)(4326008)(86362001)(8990500004)(9686003)(6506007)(316002)(54906003)(8936002)(8676002)(55016002)(33656002)(26005)(7416002)(83380400001)(76116006)(66946007)(66556008)(10290500003)(52536014)(64756008)(66446008)(2906002)(7696005)(5660300002)(186003)(82950400001)(82960400001)(71200400001)(6916009)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?z8rrbrErdDL6OVKbZ5npQkta6XJ+mDOF2m8XfLCqN4AwLn83qRm65ScoqHF3?=
 =?us-ascii?Q?p5PO8Knw+s981MowU9w6z8uDwA0PXxiFO/zlts48TtHi0iZxyR81vZlBiQOH?=
 =?us-ascii?Q?deKc8Box2POoVYH6qvccX+MOR/oyFhcn+FpeYOjkAwj+4NMKwuRZvGCi5yyb?=
 =?us-ascii?Q?FgjoXYjGv57motau7omJGdOlobcYxFOBsnjxsFXXa8VOiWuKjZjjlDFxKxwu?=
 =?us-ascii?Q?clnAjhUnc+n2W3PdCkN+eUjup4hZJx80eWKE168paoKHpA7YU9oBEmji+pws?=
 =?us-ascii?Q?4S0b2Ep/Mi2msSfC1270t3heaTNQL1bOVPwm+cFzEQZy3GtX4IWH+s8EiEQR?=
 =?us-ascii?Q?3vhk1QoWo/pNZRhHBRgijAHc5uV1OLjtXb3UHRpsFX3S0wRk7+nXOKNmOaEz?=
 =?us-ascii?Q?OL7m3GoPvcM9vPn2Gj3s6sx1WjTe4irY/+2s22l+ZMtPSqZur8GPDf4rsAKv?=
 =?us-ascii?Q?LkBFjtJgYGFcxt+OyxXuNZii9g58GSzEoTT/WevzkhffB5E6TMZoTu6J76PY?=
 =?us-ascii?Q?mmgeAIX8O7CPH/rjTsJoMzZa/GHHEpz6MJW6IDhkCyLQxC/hvv073/0cD2I5?=
 =?us-ascii?Q?zG8fgeFZdEKj53n8/IadcZu15G7+28vE5NNTzk+9eoAPIitbCKeXlWirGW8v?=
 =?us-ascii?Q?aIXfTZf/Cf1p1wvhARUODcvXN9s5w9eFnebPQARfUXOyFnhg+NPrpIWNK+dn?=
 =?us-ascii?Q?xxmyvgb40oVPHwA0mRiucvphAGFz14e5vej67vR5qRZS8QZ61U+xqv9jxvIy?=
 =?us-ascii?Q?w0+4sNLXDKykqm3CawuFDaVvtoQpSMChff0QJvATMS3pKh2Fj8Z3ETFt6yc2?=
 =?us-ascii?Q?26X/19LUV8BqtKL1Jm69lnubB0kQHu2sguUImUS4f6pE0/aaQg7tjeffDfe2?=
 =?us-ascii?Q?omQ9qkUE6dd3TWHQ7A//7Qtz4R4UudcO27LiWh4iauvdlRVUSl0K7EIxUfKX?=
 =?us-ascii?Q?7wTlmZNbMEKUQ2wMcANW3LBsTs+c3P49e97xnRglSSiPqLNsy9s6PP7cyg3Y?=
 =?us-ascii?Q?xHiOpoS4Q/ok4Nb5k+jsKdGl0uk4qY/5d5yZhPXP8e0qzlxgZklCOz4XNNIP?=
 =?us-ascii?Q?vbEWDkInFMlDAOTcfSdqXSVXYqz6XyuWkO2nTIuM6TSXE29xGLC9MLsLtpK6?=
 =?us-ascii?Q?DW1krd8QABypgEX/zApmoXo49eGZUAWcOVnGVQkxKCmB/N3sJ3/B5Hgudn8d?=
 =?us-ascii?Q?5n0uWA4H197xsDiuz0z/lBPhTNK1qWMeHBg2f2ZRg3FDX5iQDQtwDwMcrd9X?=
 =?us-ascii?Q?EpgJ/L0aIgumRx9mhCLOHVvV9x3QwbjzTfLVi9IB/WGdfcAs25h1FF8Qh8/e?=
 =?us-ascii?Q?MljeYn3r0zuf2WIJ9lJKBPUk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c569ea-82fa-4a45-8b09-08d8c93c67f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 18:40:55.0977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qUvRdhEByQcKAvDJCY5XZTigqhpjZ0xjmC6haqfx2fWKMTVp73vrOw1vFlFaXXYvnqbqHrNa3oj7YqhSBbmWrV9VjBKasRBU5dclz1bShGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0478
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Thursday, February 4, 2021 9:57 AM
>=20
> On Thu, Feb 04, 2021 at 05:43:16PM +0000, Michael Kelley wrote:
> [...]
> > >  remove_cpuhp_state:
> > > diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.=
c
> > > new file mode 100644
> > > index 000000000000..117f17e8c88a
> > > --- /dev/null
> > > +++ b/arch/x86/hyperv/irqdomain.c
> > > @@ -0,0 +1,362 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +/*
> > > + * for Linux to run as the root partition on Microsoft Hypervisor.
> >
> > Nit:  Looks like the initial word "Irqdomain" got dropped from the abov=
e
> > comment line.  But don't respin just for this.
> >
>=20
> I've added it back. Thanks.
>=20
> > > +static int hv_map_interrupt(union hv_device_id device_id, bool level=
,
> > > +		int cpu, int vector, struct hv_interrupt_entry *entry)
> > > +{
> > > +	struct hv_input_map_device_interrupt *input;
> > > +	struct hv_output_map_device_interrupt *output;
> > > +	struct hv_device_interrupt_descriptor *intr_desc;
> > > +	unsigned long flags;
> > > +	u64 status;
> > > +	cpumask_t mask =3D CPU_MASK_NONE;
> > > +	int nr_bank, var_size;
> > > +
> > > +	local_irq_save(flags);
> > > +
> > > +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > > +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> > > +
> > > +	intr_desc =3D &input->interrupt_descriptor;
> > > +	memset(input, 0, sizeof(*input));
> > > +	input->partition_id =3D hv_current_partition_id;
> > > +	input->device_id =3D device_id.as_uint64;
> > > +	intr_desc->interrupt_type =3D HV_X64_INTERRUPT_TYPE_FIXED;
> > > +	intr_desc->vector_count =3D 1;
> > > +	intr_desc->target.vector =3D vector;
> > > +
> > > +	if (level)
> > > +		intr_desc->trigger_mode =3D HV_INTERRUPT_TRIGGER_MODE_LEVEL;
> > > +	else
> > > +		intr_desc->trigger_mode =3D HV_INTERRUPT_TRIGGER_MODE_EDGE;
> > > +
> > > +	cpumask_set_cpu(cpu, &mask);
> > > +	intr_desc->target.vp_set.valid_bank_mask =3D 0;
> > > +	intr_desc->target.vp_set.format =3D HV_GENERIC_SET_SPARSE_4K;
> > > +	nr_bank =3D cpumask_to_vpset(&(intr_desc->target.vp_set), &mask);
> >
> > There's a function get_cpu_mask() that returns a pointer to a cpumask w=
ith only
> > the specified cpu set in the mask.  It returns a const pointer to the c=
orrect entry
> > in a pre-allocated array of all such cpumasks, so it's a lot more effic=
ient than
> > allocating and initializing a local cpumask instance on the stack.
> >
>=20
> That's nice.
>=20
> I've got the following diff to fix both issues. If you're happy with the
> changes, can you give your Reviewed-by? That saves a round of posting.
>=20
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index 0cabc9aece38..fa71db798465 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>=20
>  /*
> - * for Linux to run as the root partition on Microsoft Hypervisor.
> + * Irqdomain for Linux to run as the root partition on Microsoft Hypervi=
sor.
>   *
>   * Authors:
>   *  Sunil Muthuswamy <sunilmut@microsoft.com>
> @@ -20,7 +20,7 @@ static int hv_map_interrupt(union hv_device_id device_i=
d, bool level,
>         struct hv_device_interrupt_descriptor *intr_desc;
>         unsigned long flags;
>         u64 status;
> -       cpumask_t mask =3D CPU_MASK_NONE;
> +       const cpumask_t *mask;
>         int nr_bank, var_size;
>=20
>         local_irq_save(flags);
> @@ -41,10 +41,10 @@ static int hv_map_interrupt(union hv_device_id device=
_id, bool
> level,
>         else
>                 intr_desc->trigger_mode =3D HV_INTERRUPT_TRIGGER_MODE_EDG=
E;
>=20
> -       cpumask_set_cpu(cpu, &mask);
> +       mask =3D cpumask_of(cpu);
>         intr_desc->target.vp_set.valid_bank_mask =3D 0;
>         intr_desc->target.vp_set.format =3D HV_GENERIC_SET_SPARSE_4K;
> -       nr_bank =3D cpumask_to_vpset(&(intr_desc->target.vp_set), &mask);
> +       nr_bank =3D cpumask_to_vpset(&(intr_desc->target.vp_set), mask);

Can you just do the following and get rid of the 'mask' local entirely?

nr_bank =3D cpumask_to_vpset(&(intr_desc->target.vp_set), cpumask_of(cpu));

Either way,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

>         if (nr_bank < 0) {
>                 local_irq_restore(flags);
>                 pr_err("%s: unable to generate VP set\n", __func__);
