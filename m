Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73B7366189
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Apr 2021 23:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhDTVZu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Apr 2021 17:25:50 -0400
Received: from mail-eopbgr770093.outbound.protection.outlook.com ([40.107.77.93]:15685
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233769AbhDTVZu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Apr 2021 17:25:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=armgNq3rV/HeF23HrJIbDGFfdPFlt5LTnoW2Jkcc+vla92f+FILyTbLmCFMXwBLW7u6tI3QjvfCQtdgmL2pHM4KK1nsVdsL/zGpnUfyJptJxO5HEUUQSSGYtQOt/hWbaYUH1ZFjwqbS2lURvtQcL+w6BppHROTLbRYSP41Mm1iByPEmjfKE+lxESAPexpckzGvMyRoc5sz3zmyGref3rYPfM9pRQogS0c67ne3W5jBsanvx9ifjYyN5ksOSu6rGJgF/7+yLOAp5wbuaq8GbDWOycvKlj28QWJvZNAiix8ZZBJJPx4/USUB99/WBc8PZ0Giw3EcXGGt2xC2QjwFpecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ihOejIQUIbBdhqiHXA7CgSW5hniZkTVj9/H56uMYvw=;
 b=bsGVR72AZbPYp0RZhyrjRruNYQ5VB2ppQSYvf9+rwl4pmAUyE41L6nGubzKuqfmYY6t0juke4Nee+9aj5vFrznuhb85w9gMOR3N9AubKevnJ8t8uXwynCEa53+FrqriFPjvK1RAbwxVZlEioXVWM0RUlAAQQydbv3xxGaqwDUA1InSojW7vtaWjLGskiwOP/0EjtQPCeGirGjUDSE8LT4XkM2LP12n285cIbmv6VQsAWVtGauxI6Ibj4pl/MbdvFzd2A6css+FHPpF8gNqOm6Pqlfg0rJ8WyQ/r2gJBB/AF1BUHGJ7/UAQSl/lKQRhlPU6/ZHIpDcWrNyOP6Yb7Iww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ihOejIQUIbBdhqiHXA7CgSW5hniZkTVj9/H56uMYvw=;
 b=X26D0Z9ecJx+RCS/nUNh2NL3z82+lDwnkXEGPThHLt5trOx0ojjsSOb9XpKNjvKifAgwf7kLxfO0onQL8NiUb13Zm0WoEmsEFiaDp8XoRdA/4LSbTxZ1xJfs8MJrUEG1TRpMVsAofdXh3fD1NUjLWtDoCAecx/h4DeFcx1Aqyrk=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR2101MB0874.namprd21.prod.outlook.com (2603:10b6:301:7e::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.5; Tue, 20 Apr
 2021 21:25:16 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%5]) with mapi id 15.20.4087.015; Tue, 20 Apr 2021
 21:25:16 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Joseph Salisbury <Joseph.Salisbury@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/hyperv: Move hv_do_rep_hypercall to asm-generic
Thread-Topic: [PATCH 1/2] x86/hyperv: Move hv_do_rep_hypercall to asm-generic
Thread-Index: AQHXMyKl7uqAeaa9w0ufXHoMj3A0Kqq98OAQ
Date:   Tue, 20 Apr 2021 21:25:16 +0000
Message-ID: <MWHPR21MB1593FA3F2A4FEC5CEFA2BCDAD7489@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1618620183-9967-1-git-send-email-joseph.salisbury@linux.microsoft.com>
In-Reply-To: <1618620183-9967-1-git-send-email-joseph.salisbury@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=922835b1-1302-44da-9211-c11e766c653f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-20T21:24:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 740c2eb7-74fc-4ba9-d0fa-08d90442caa9
x-ms-traffictypediagnostic: MWHPR2101MB0874:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB087420FB615B2B0AA90C34B7D7489@MWHPR2101MB0874.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mm33mGAwn9nfreVb/K+lvoIzgIRl33hw4tkQ5SvIWDE5n0nWO6ffNkrwBQAFRa+FPjqbS5/K8d85R/HfE8/TsrWql8haKoB14q/bmo0jkZG0IElZkKK8xc8Ske5t3fv+C0vBxUblOwdG0iRSYyRDuYTMxvwCl2HLjm2lu8+I7T4xiBHXtWsIVD71ZgwWOXZXQnFLKlbnS1Cm3rLYmpIg909bmsLO/x+V5X8x3L9H6GhFwVgwxOIOJTUcZRp2qypPkZgcthCd9aMDJdjVE0INqYs8unJndQunzkilsWs3H8f4NxPY/cCVY0V7rzzrehCAp/VitihdZulvP/gAr9Tsmj/5Rst0avCbqAcvcTc6nzab0wOcBQ3fcH02iyNzcgSmBpK4oAMuazT9mXRGovzgrxUC8zY8Oj8QuWhDPmkMRYUJrGA6XIHjyv5bOvEikj5dPMp5aAAS2N7IQy7dLii+YaiznTZm67nmfVjkYbBL+lI53QIJdWuqCzKCbxJL3E11Y5uLIalefYRpBT/UKk8x/b30jmAZq5efcmW+u3vJisOzM0miS9aio9wE/+HP/XIMhiuII/lKT7nQ8492N+rzboSBSYl6AfCFTO1htzU/+YNNkUb79Aw9li/r+DIRekYJw+8ILZBk+5UNXsSNT5arbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(33656002)(8676002)(10290500003)(66946007)(66556008)(8936002)(7696005)(66476007)(54906003)(9686003)(71200400001)(52536014)(4326008)(64756008)(186003)(26005)(110136005)(6506007)(478600001)(2906002)(316002)(55016002)(83380400001)(82950400001)(76116006)(82960400001)(86362001)(38100700002)(8990500004)(5660300002)(122000001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hCapIfu9mduuHkS72e73tQYO6UXlDhOsUnSg3u3UZo65OjdrMwQNDQxQljTV?=
 =?us-ascii?Q?/DBQwoBP0hQU8ald9OX+ma9t+V2wd4BFHTtmSyj0ACkiH6Lz3607imX5mzml?=
 =?us-ascii?Q?o2yjf5miw+Bobiph0OxzjxANdItVvcLLyODQP2kdtR9MmBBJErrkLV2lspzg?=
 =?us-ascii?Q?2ypmKoy6qXbiYUkeq2bO11q12SLpVwy6GbADOTBbQ2G9u9f0EcpmeGFxe7uE?=
 =?us-ascii?Q?jQWi1p2+QkcDfCTiZWHxK1UtZ4awtQoQB5lj2qFxeCARedUskxVLncVibiPf?=
 =?us-ascii?Q?X6R6nwx9ELfzLP4aw8CX3JpPOXvL4aMJL3/0UVeSHyM/YG0Typr2IQO5zbka?=
 =?us-ascii?Q?+h6hhm/g5g08UtJvXuMGYIaHtdqQgGg6MwqIepr4MloZNB8JZ3XnTQpIhWQv?=
 =?us-ascii?Q?wptkubMe4XyzYSc1rlNA7UwSJaNeKT4B5djhPBRwjmMiipZaMMIwy8VelQFh?=
 =?us-ascii?Q?MwsJDBcoLQzIlsE9INI0xR6D9UK5LP5QoFwroYD2qaptSXhNcotdLIZnxCs+?=
 =?us-ascii?Q?IwAxsyXG/vdtYGb78BhQvwzIqEJlUbrwmpa2AC26NO6JngHAhkp4htFmTIi3?=
 =?us-ascii?Q?IHeXXWle8BPvrIdEr1P1ZKnfSse0QMea6cvwFcov90NG8bQMY1Gvgyqnh9MS?=
 =?us-ascii?Q?eQCz9nYwKymNr8O2nEwhHowr+vEsP5xEO5joZzoE9idapl/a+7DD9NSiEnYB?=
 =?us-ascii?Q?jCkVwHhFii08sUV2ku7yiy15DCPWWGwwyhWDZIyQROUArqByDqn6XyUBCSsZ?=
 =?us-ascii?Q?b7j8CsrRxCjmMx/EZOmM0AJ3wpRqHRWTxEab5Ql3PdjH3A3AxyU6aSpBX16P?=
 =?us-ascii?Q?Bvz2R2AwGgzliO+d1hZIRGlaZHjZnGCHaug1TrAV/sAmBD07Tql6pxJaOHEJ?=
 =?us-ascii?Q?GNdqVTkR8zh9EGcDOC5zZrbnE1XlAVtvkNquEoRwoAAsMmdC1rGeKpS9Xx4n?=
 =?us-ascii?Q?t1H79E3R/gKy5ZzG34XwsQFddVMFbaGrUK8CBfanVT/A8pxf60UB3Oa81e1G?=
 =?us-ascii?Q?STmNI5ytIZX3JEmI9B2Q4xi3mEzl3OZ1GpLyt+0qE+85h2XW+y8trXWtqlfC?=
 =?us-ascii?Q?J8kYEp9kDRxtKp41wsuljXlbJ653mayQlWLieNtgw5MmH9LwN8jlFXNFwDXl?=
 =?us-ascii?Q?CuNIzvSTJnIQoierrUCOU4PuYMkhGS3lwXwG52DmmBg6IH3nWYcq16++wa8t?=
 =?us-ascii?Q?kLG+ysUxd/wvmD3YFm68BKWt9KV/UBxVedT1QevgbI4XVgfAB64kXJ8Mi4TA?=
 =?us-ascii?Q?5A2aGgUW1H/Z4pQGTv05A1Y5qKMcqBfDY0E0j994KIefbrzgc9XXnA1hU682?=
 =?us-ascii?Q?bJDsCtS3BD7gYdtID1T+iZCr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740c2eb7-74fc-4ba9-d0fa-08d90442caa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 21:25:16.3465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTScDRwt2V9lvHydXFLjfFmfafloqoAHQ76FlK/kSxn/6AMXbHwCqzxbeiBq1YRkqCb9JULu3ej9Kn1THPb608OOI2EbA1rQrs/IgHqgLcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0874
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Joseph Salisbury <joseph.salisbury@linux.microsoft.com> Sent: Friday,=
 April 16, 2021 5:43 PM
>=20
> This patch makes no functional changes.  It simply moves hv_do_rep_hyperc=
all()
> out of arch/x86/include/asm/mshyperv.h and into asm-generic/mshyperv.h
>=20
> hv_do_rep_hypercall() is architecture independent, so it makes sense that=
 it
> should be in the architecture independent mshyperv.h, not in the x86-spec=
ific
> mshyperv.h.
>=20
> This is done in preperation for a follow up patch which creates a consist=
ent
> pattern for checking Hyper-V hypercall status.
>=20
> Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h | 32 --------------------------------
>  include/asm-generic/mshyperv.h  | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 32 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index ccf60a809a17..bfc98b490f07 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -189,38 +189,6 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u=
64 input1, u64
> input2)
>  	return hv_status;
>  }
>=20
> -/*
> - * Rep hypercalls. Callers of this functions are supposed to ensure that
> - * rep_count and varhead_size comply with Hyper-V hypercall definition.
> - */
> -static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhe=
ad_size,
> -				      void *input, void *output)
> -{
> -	u64 control =3D code;
> -	u64 status;
> -	u16 rep_comp;
> -
> -	control |=3D (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
> -	control |=3D (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
> -
> -	do {
> -		status =3D hv_do_hypercall(control, input, output);
> -		if ((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS)
> -			return status;
> -
> -		/* Bits 32-43 of status have 'Reps completed' data. */
> -		rep_comp =3D (status & HV_HYPERCALL_REP_COMP_MASK) >>
> -			HV_HYPERCALL_REP_COMP_OFFSET;
> -
> -		control &=3D ~HV_HYPERCALL_REP_START_MASK;
> -		control |=3D (u64)rep_comp << HV_HYPERCALL_REP_START_OFFSET;
> -
> -		touch_nmi_watchdog();
> -	} while (rep_comp < rep_count);
> -
> -	return status;
> -}
> -
>  extern struct hv_vp_assist_page **hv_vp_assist_page;
>=20
>  static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned i=
nt cpu)
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index dff58a3db5d5..a5246a6ea02d 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -41,6 +41,37 @@ extern struct ms_hyperv_info ms_hyperv;
>  extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputadd=
r);
>  extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>=20
> +/*
> + * Rep hypercalls. Callers of this functions are supposed to ensure that
> + * rep_count and varhead_size comply with Hyper-V hypercall definition.
> + */
> +static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhe=
ad_size,
> +				      void *input, void *output)
> +{
> +	u64 control =3D code;
> +	u64 status;
> +	u16 rep_comp;
> +
> +	control |=3D (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
> +	control |=3D (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
> +
> +	do {
> +		status =3D hv_do_hypercall(control, input, output);
> +		if ((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS)
> +			return status;
> +
> +		/* Bits 32-43 of status have 'Reps completed' data. */
> +		rep_comp =3D (status & HV_HYPERCALL_REP_COMP_MASK) >>
> +			HV_HYPERCALL_REP_COMP_OFFSET;
> +
> +		control &=3D ~HV_HYPERCALL_REP_START_MASK;
> +		control |=3D (u64)rep_comp << HV_HYPERCALL_REP_START_OFFSET;
> +
> +		touch_nmi_watchdog();
> +	} while (rep_comp < rep_count);
> +
> +	return status;
> +}
>=20
>  /* Generate the guest OS identifier as described in the Hyper-V TLFS */
>  static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_versi=
on,
> --
> 2.17.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

