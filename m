Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D716B3635EB
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Apr 2021 16:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhDROn0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 18 Apr 2021 10:43:26 -0400
Received: from mail-dm6nam11on2125.outbound.protection.outlook.com ([40.107.223.125]:27105
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229446AbhDROn0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 18 Apr 2021 10:43:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkOoQQ4awAM3KKOLoJxfjJWnvDX33o8tZWw4pCJqT6ZTehDmtvwUeju3i1L51ZLRaZ0UfyTWBfiLhUlUme+3lWShfhp03b7fKlVnEWj8/qlnPbBL4/OOl5HoIT5HykZW0LWhZkUzkn4MBtFgobvY0qibHacLQRaHXHf80U2rzak4MORXn8VO0rJggR1ehd9RzarR9uz5k90CSI6vg9fgCs6YK0Hr3CPBiJC1cuv7C0ESyp5S3wVaMjZhf8q4OUMv+Xq/MXa8Yivayij47NNHUI/VZxqxFNaIHCe43/xcm+GujxcwKVqTt7QecP/eKsvuGjJK3UG985oGKGofMhaDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fB2bhdtNhqr021P18F0pnMpOhDxnnC2U8UdPXfZ4xuQ=;
 b=ZTIprdFyviBR3mg52uVk+VSmdN66Ssgbx+aojxB/cFpe1u+mbitLexIvIb7sCwD+puHmGWHozD33DVNAXyW6ExdvBfD7K9gZvUvozlBRB/tXMx+S8LVeIKbShy9BBEDTcxI4u3M5V7zdtgfAy77bw75rfIoowd/hayr+7y92ex7lGuljsjmNX5C4//T5Sr0qNWn6rJxHckWdGWZozrleGHvWpu1iYrZ6UqSssCIjPmEuEFmGBbzVrN55sUGEY5rgNoPLAd8DuPMdzyhHBFuJQyBBIQ1WGgLjm9s8G6x49rLW94XJD6I4BnFnVy+z4blTAQL/5j2C2nEvByrP9NKGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fB2bhdtNhqr021P18F0pnMpOhDxnnC2U8UdPXfZ4xuQ=;
 b=R4fNtHeGeh7cFAdR9uUciSbDF32G/zDU25j8o6+1dRlqJgh/ocbgdBKrGIKwafTQfjslYY/hlcBWK3HxpvO449ylCNga2cRk15/JuGS9XaS9llywkYiWGetsIIvdLnoec9WCjFdxbp2ZfHgCrQWMgnaFLm2gmCUQsOCLMbNUATw=
Received: from CY4PR21MB1586.namprd21.prod.outlook.com (2603:10b6:910:90::10)
 by CY4PR2101MB0804.namprd21.prod.outlook.com (2603:10b6:910:8f::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.7; Sun, 18 Apr
 2021 14:42:55 +0000
Received: from CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::3937:fced:99af:ea01]) by CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::3937:fced:99af:ea01%5]) with mapi id 15.20.4087.011; Sun, 18 Apr 2021
 14:42:55 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Joseph Salisbury <Joseph.Salisbury@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/hyperv: Move hv_do_rep_hypercall to asm-generic
Thread-Topic: [PATCH 1/2] x86/hyperv: Move hv_do_rep_hypercall to asm-generic
Thread-Index: AQHXMyKl7uqAeaa9w0ufXHoMj3A0Kqq6QbyAgAAVtlA=
Date:   Sun, 18 Apr 2021 14:42:55 +0000
Message-ID: <CY4PR21MB15863413859BBF15CADD214CD74A9@CY4PR21MB1586.namprd21.prod.outlook.com>
References: <1618620183-9967-1-git-send-email-joseph.salisbury@linux.microsoft.com>
 <20210418130903.5r66yzm6qxizfrop@liuwe-devbox-debian-v2>
In-Reply-To: <20210418130903.5r66yzm6qxizfrop@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9fb20264-2749-46bb-abfb-8686c7148964;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-18T14:26:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62267f1a-7cfe-4a50-244c-08d9027840c6
x-ms-traffictypediagnostic: CY4PR2101MB0804:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR2101MB0804E069B09BBD15343DF905D74A9@CY4PR2101MB0804.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +oTSsL6HAq1QoiDlGBSbJuyFyB7ZpWRWnJxuDrR4SGMW/xmeZv9+C2kEKdPexiBx4o2flVP4luYD92/BWf2eIK1vS8DW3p2IBoVAZ1ssrlmRCHl27GpQYIHBdQAm+vlgJ0OxpPnwOTcWWxBWvx7TD4RonIFwBAgvayJnkLukhUCNFn7opVXw5m1tIdbu3fsUAqi/Fbmm0Leh/H/I0Nq2Tx7TLcfzt8ocIrv+C/kSbj02VcjJ5BNZjF/CZR8+NGMGS6IrZpJmYxpF2rd4LYYCujWTZhZovoHkOBIwLEZ+Q/qb3G+uXoKy7kvmkKxDwCJukXbiPS2NFywmdhK8lTNPx4ivTazt2QWZzh8tMMQAvdU1lsJYhOaIqXcyF+0LUMiUz9fXd8k4KnuQzYn4iGyf8i5fq+5+4kDXtHlL7gtXDSCmBR8eA+xzyLIbaBQzBq3cI7SOWYlMZzWp0aD+Ko5ny8XprV2vxlZHER8bhWE2liss+Ta5FgtMWgT3S7raTcVeQjd2W79dUTM0IAJfzxUijajdcqYPV9hwBy/wCvlpBNLTmVxZmcd0Gr53YhjNouAXtYvEUyLyp9RFwovdl+hUJicOTm/I6Yd0r5Z2X/aq7wx0RnockUQcj21mx4KH5EEXpMnkijDxOJdsIwoyh3EH9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR21MB1586.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(71200400001)(52536014)(8676002)(64756008)(66446008)(8990500004)(66556008)(66476007)(5660300002)(122000001)(8936002)(4326008)(82950400001)(38100700002)(186003)(26005)(82960400001)(2906002)(7696005)(54906003)(9686003)(478600001)(86362001)(10290500003)(6636002)(6506007)(66946007)(316002)(33656002)(110136005)(55016002)(76116006)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?E9hllQsW7nbeyTBBqeTEKkmTzS3WF5fYb3qEEnb0LzNOF6v5FGcIgMFbXMph?=
 =?us-ascii?Q?BxKC+ga0taFsfWLKT4bIKUSmOnW96f6sy+aPWKmXNCEDRKmwOvx3uh4TUOZJ?=
 =?us-ascii?Q?E9NFHN+jpbkYADeY1J3UuSAp8UyIB4Z2VF+V0kjvjFi9/ZTUW1yywkQS0gD5?=
 =?us-ascii?Q?aymnVimedfPNAvq2kibC7M7LCICkjGqxIJTDnC/1sp2F7C6XKoj39ZsHnQM3?=
 =?us-ascii?Q?imEQPtoHXvqrq5XL9oZ2sJGukCqAkhTbKaaFHeGFZ03ud7eKkrHJk8YU6q+C?=
 =?us-ascii?Q?MpP4vJY1KVQXjoPv2lUdcrwhwdC1eQEBmqmJNiRrxAqn/CQg5HxRbHJ4WtPj?=
 =?us-ascii?Q?RbNZtsnqFuywdiyN4IoooJ9DO1enSOZe/dFaEFqhnoLJ9/yG8QHR6if4tFYq?=
 =?us-ascii?Q?aahNNokYTI7fzmyzEnR0BPCcA6/dFFr955nYorBLN4r3YnHPBi7GtsHlee7T?=
 =?us-ascii?Q?p55sawB/LftNOadRusgwGhPeL3nxKIdKskz7ClIfyC9rm4vDYMBkQRM8ZLyc?=
 =?us-ascii?Q?GNM3KZC76Jqjk571i5NvCoce1nQsJc1RYRdrpZpM2E/ryGSq4XAf012xSca7?=
 =?us-ascii?Q?Hs0gTp7yA6PP/e+gQ45BNXcOu0TYs8U4B+Q5bZwK1LbHqcA2VjpksGs8TTE6?=
 =?us-ascii?Q?nJFn0NI0tKEAB1d+LmxP4w7x5FPxhnf92dxa1JPpPPPXCTh7GPVfuQTBZopV?=
 =?us-ascii?Q?b6L8WH4JVxbgYIZKyYmGN0YRhEy3lQqCodD9xemQnCNAzEiqA4uXStJlJ+iK?=
 =?us-ascii?Q?SDdfDhb0FysRw1xIdxfROPLs+EgEv7cQ0KgSLdZ15sslos8NTQF4kP2Yc1M+?=
 =?us-ascii?Q?KxI8KdPmJk1x82ksK/caF7SP+MfI1rYFJmtIJ75Cf4mrGrFa7unxW9snzCYJ?=
 =?us-ascii?Q?76NE6dKGxkUZu54MaUAXs9LEyMy6cMoZzu8C9e/FGnImWHyz8qFBzFwl0XKe?=
 =?us-ascii?Q?Spw0XMS7IEUa4kqHhBh6ZPsbXEssFQtAqQ2Oqc8i0o0XDpTWfx8V7bDtp07W?=
 =?us-ascii?Q?5g7IU2MD1hxWvDvrlJeOgd7BSMqMCXNvBDRS19Ki6iBWhFQj3biPYJWkGmEg?=
 =?us-ascii?Q?71ML6cUPjl24k0tAz3gBAYy2f/aWK6ebpwrsRMSsQRBUNXRmg+Jp4aNDfKhA?=
 =?us-ascii?Q?IZRCyOOsaMoBh23W3eIfTZVnRCIokUrBg7kamT1vEkUVBuhCiSc5TVK9HM6t?=
 =?us-ascii?Q?kEYXjNN4lTXYPnhS44yofJz1VrGiuxCDeoTTKRIl0jK4KNugYVtSjdBmTmHN?=
 =?us-ascii?Q?5BVnHjHMXp7TYOq6zYQpurNDrSV6dWDLhMVrVGCBl+pZnRqdQb1GR5oMOPCL?=
 =?us-ascii?Q?Q9FoJTVh03UA25ebNCU+Hjaf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR21MB1586.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62267f1a-7cfe-4a50-244c-08d9027840c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2021 14:42:55.4434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fcaEgAOKyc5FNPW5G6YQTkcgmfo4Wexf0sLt163eznBwPc2zzxDw9tk4IYS9Oq4HWXHcafVanD+Bl9OzkXGv2Y4smjtcy58RU4RPmlREzPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2101MB0804
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Sunday, April 18, 2021 6:09 AM
> On Fri, Apr 16, 2021 at 05:43:02PM -0700, Joseph Salisbury wrote:
> > From: Joseph Salisbury <joseph.salisbury@microsoft.com>
> >
> > This patch makes no functional changes.  It simply moves hv_do_rep_hype=
rcall()
> > out of arch/x86/include/asm/mshyperv.h and into asm-generic/mshyperv.h
> >
> > hv_do_rep_hypercall() is architecture independent, so it makes sense th=
at it
> > should be in the architecture independent mshyperv.h, not in the x86-sp=
ecific
> > mshyperv.h.
> >
> > This is done in preperation for a follow up patch which creates a consi=
stent
> > pattern for checking Hyper-V hypercall status.
> >
> > Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
> > ---
> [...]
> > +static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 var=
head_size,
> > +				      void *input, void *output)
> > +{
> > +	u64 control =3D code;
> > +	u64 status;
> > +	u16 rep_comp;
> > +
> > +	control |=3D (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
> > +	control |=3D (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
> > +
> > +	do {
> > +		status =3D hv_do_hypercall(control, input, output);
> > +		if ((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS)
> > +			return status;
> > +
> > +		/* Bits 32-43 of status have 'Reps completed' data. */
> > +		rep_comp =3D (status & HV_HYPERCALL_REP_COMP_MASK) >>
> > +			HV_HYPERCALL_REP_COMP_OFFSET;
> > +
> > +		control &=3D ~HV_HYPERCALL_REP_START_MASK;
> > +		control |=3D (u64)rep_comp << HV_HYPERCALL_REP_START_OFFSET;
> > +
> > +		touch_nmi_watchdog();
>=20
> This seems to be missing in Arm. Does it compile?
>=20
> Wei.

touch_nmi_watchdog() is defined as "static inline" in include/linux/nmi.h. =
 So
it should be present in all architectures.  It calls arch_touch_nmi_watchdo=
g,
which is an empty function if CONFIG_HAVE_NMI_WATCHDOG is not defined,
as is the case on ARM64.

Michael

>=20
> > +	} while (rep_comp < rep_count);
> > +
> > +	return status;
> > +}
> >
> >  /* Generate the guest OS identifier as described in the Hyper-V TLFS *=
/
> >  static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_ver=
sion,
> > --
> > 2.17.1
> >
