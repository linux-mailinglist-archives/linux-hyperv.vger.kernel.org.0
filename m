Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A122A3A3375
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jun 2021 20:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFJSoS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Jun 2021 14:44:18 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com ([40.107.220.130]:17440
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230080AbhFJSoS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Jun 2021 14:44:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDZErqF6Bufc0gqm/059S0yCBaWQdAjPfeWs92CtPpJSZ/3w6XCG1TkBK+YzNmvrToaH393/XdezURGytjZ1+cyZ8YX8Rn8Nu8lvnqjwsowiowzgCQELVfP9Or+aafAdnoYfekGfc18V7lhhKqknxLP9Hf3WiNeuUuQCZU0bEVFeray9lCKLD3tfUDqaFwzzJqu8VxZRRl8oRSxa9Pq+CWT+1gzAaBqzHALwraeDU9MTF85oWMc8XfeEJPtIYfHU1gD6yd3YroyC03nJWAf3eCHS7u8frEMakGkg/c/PDKK4DsQtcxecuML63BQrRChJmT1fEQxaMpDEnm+PU26m+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoCih7N3CvPg2XFlcImjCZDzGtu5SqmkMITc21QNmTg=;
 b=oIBtZ+N3o7Y5llga7OtcJEnTtStf8xCGoVhsV05XMZkAd25GsV03whssOKbuCltos9KLGsDYw/WYvArM9AYBBTSk3FcCZQgAlDKec9EBs8cs7IsDffqNh5fbIRFjTDZ4YmxMv/cn5M3rVRpmLTIsOhlgele5svdAr0jkhnsYoBaoqE6b0zWr+WXqDyKytQTUTtYhk/KCjg8bRlsYpDyVYcm+JWU7b5+6CJmlIBl/K5lOTZxMXaQf9S0rV5EaZA9oVtM/g+5/w5xe7U7IxJ+KX2e+vtYxMz1igN2+n1j8fN4ojslteb7nOsVYKeXPS/tiIjkInE6BtekluJma0Cz2zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoCih7N3CvPg2XFlcImjCZDzGtu5SqmkMITc21QNmTg=;
 b=QRTf56Y0yDJ96YOmZ7oigX3/8F4xRMwtvfXa6Bdw3ocD78OmgBVepmhWz37WVEKfSTyTJNHlT3TmYmVuQU5c84jQh/yrJeluhAZxdFKAdBBYTbsRMEvfqa9aI0c4YlI4xqfd2I8jXoGbqz3ydH6rN1kGzmSmk+dB7YefttFoDPY=
Received: from MW4PR21MB2004.namprd21.prod.outlook.com (2603:10b6:303:68::24)
 by MW2PR2101MB0891.namprd21.prod.outlook.com (2603:10b6:302:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.8; Thu, 10 Jun
 2021 18:42:17 +0000
Received: from MW4PR21MB2004.namprd21.prod.outlook.com
 ([fe80::b086:5b59:c7f1:8723]) by MW4PR21MB2004.namprd21.prod.outlook.com
 ([fe80::b086:5b59:c7f1:8723%9]) with mapi id 15.20.4242.008; Thu, 10 Jun 2021
 18:42:17 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 02/19] asm-generic/hyperv: convert hyperv statuses to
 strings
Thread-Topic: [PATCH 02/19] asm-generic/hyperv: convert hyperv statuses to
 strings
Thread-Index: AQHXVBLqReVSLKC9j0KX/QmKD4OHXKsNpaFQ
Date:   Thu, 10 Jun 2021 18:42:17 +0000
Message-ID: <MW4PR21MB200490109062F93EDCBB3DE7C0359@MW4PR21MB2004.namprd21.prod.outlook.com>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1622241819-21155-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1622241819-21155-3-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b97f789c-5c91-4169-b8ef-08d92c3f7936
x-ms-traffictypediagnostic: MW2PR2101MB0891:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0891E0B236FBF2A7C69E990DC0359@MW2PR2101MB0891.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:256;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ylGtEfbwIKfo4Me0xdWRBjyD2jXG+60whw7LeSgvZ/2B//LySlTInhMZYVwv8MVCf+imaO81qxP+ez6WrEgCwva+TeOaw3MRBsjcbCGF5UjaHIoeE4FAoGknQip5bTUF+7DKJD08i75p5KI0xDthfFd/D5nGZ49QpC+Ct8xEec1VhBpy6lp87c1yLa1m6eqmHr/wNVNh0OsLHm6xZtvpgLyQtzScuiZNtJBbGIPIZt74M2Fd+vRgh3rhlN3SdxjhNg7bqGVJjhiVH+4B4upBuwWsj4rdWd9gNfKsvjFLGIfEjyusky+7YDeDMj1dhgvydKgfaz0bcl5mUEt2TxWJoRxg0jiyniY4rZ4K9x3yDN9bcv7nSYpDdDreUO5PHUw9s3gOQiOctuy2Ech+4oWKD0ArlASoJgYbD9yZ2KjndAkCUJaP3qCcS8YRzoSAAvPNM5WAAlAIgqQvTy7gMgVThYDMsVio+4qhNwwe/knmcpCv0jsXiwgih1dtBXyqYm4TQDbJHGGK/NL+d+dynzIkW3uVjd80m0q9thlL1MoQKW8+KOxyHCRIuHwtsI4QcgkKbkFQdCBynjKMmkwVli3o/MOSZVM2jsE/qSeQYa3QSuNbUFDJmR+achFq3HmDLnQuwNYaZ43X1Rdst9tkqc3LOkFtYbcEK+yExjH+uG4fehRt6vkhJs6jUzbEjAJlfmkcyI7YHOXloZSRNHpV+xeEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2004.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(10290500003)(76116006)(66946007)(66556008)(33656002)(71200400001)(66446008)(5660300002)(107886003)(52536014)(83380400001)(8936002)(82950400001)(54906003)(110136005)(6506007)(38100700002)(53546011)(7696005)(82960400001)(478600001)(8990500004)(2906002)(186003)(66476007)(9686003)(316002)(122000001)(86362001)(64756008)(4326008)(55016002)(8676002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZnFcc6wD6PPmF5wWTra2xwIQyAcyiWMXdoD/Hd6sx9QQHqfnXM4us8ITadln?=
 =?us-ascii?Q?7iZ8Se34e9KC3Pd+g89uEoxRSkfnbBdTypajEk1dNXOdgeUFeUX93aVemLbt?=
 =?us-ascii?Q?hErytpcGVI65TlXNd6XRLIuHrvda6UTRRDsK88G4tE6CCkCWowHT8o9kd/VD?=
 =?us-ascii?Q?N32hn5QkskolYyB4G7M7aCUUESnBTNsMLTqxELdr8sf8GuwjQZDRLpdQlryQ?=
 =?us-ascii?Q?n6l7j0UVNe5COWvg8VFNm7rpXv60Rsk07UNqa0zH15BDHa9qWcZbmSVrNSbt?=
 =?us-ascii?Q?DomS6mLD99ouSxBHIklk/tGM6TBBTNa554I1BCw2LAGpHxo/+7BB6zkCPPM3?=
 =?us-ascii?Q?kg99EvQyCh7wHXVCfK8qHXldjPM/ofMFU1kpXMOFR39otQBm8b6mqlKNdles?=
 =?us-ascii?Q?2UDoipw5gbSt34B/bmMZsAJphMqWgsuHzwP5dsiD08Yz18Rr2+fSHNJRN+rr?=
 =?us-ascii?Q?5uaKpbDwZ0qdHAmVZtiMAokzUPMYkYMtlX11Mxk4aD/imscJVWUnUHyx9/Np?=
 =?us-ascii?Q?xgU9ZBofiAlaov5xnPKHQ2YPLwew3ZgwBCZrlEDqIv9ZLWIWyx22WpX1lkJ4?=
 =?us-ascii?Q?TJT99I0W0DXDaylzL1S0DF7jRUrQNsXypjoD5ygJYUGiutT1cs49fjItuuwl?=
 =?us-ascii?Q?VAe4eyH91EG4djxtpOro2Our54+I537WZ9FG/drPwK415R9cI0MpNdxPQn9/?=
 =?us-ascii?Q?Yvc7Pi4dgAMmMY2bZfLLcdtdG3PHWXArw226sfIb0wlp8mgTNB9xqS4CQHMl?=
 =?us-ascii?Q?vIgvnU7Ia558/jZfkj81PrkIDSBre1pm93RZaNlxNasveKab6LEELO/C+PNo?=
 =?us-ascii?Q?4YaZ5RurZW4yRcZe91fASblFKLC7YLgQeojQKtKnxte54qaA9EDhpk0Rw94a?=
 =?us-ascii?Q?7kRexkw456l8Vqt/WptCC99wqwfoJRKS+dsiS1qVVhasdsW/bABC/vQgkyxy?=
 =?us-ascii?Q?YbjGAC7BS9xqlN+DOnkFRhe8s6I/0jsiiAtwxqpJFLuEFTmYPERj2xdrORdD?=
 =?us-ascii?Q?OvSJ4VaPNs9AH2HoCV9cXnuHF5ASvulHGmAeCOsYg7WGxg1loHiJ4ryQMsSf?=
 =?us-ascii?Q?FB8rvUfZC8xXy82yJIZKTPjnEJRCmGvhwXXbLpXmaOG5CUd+CcltLAfd71Fi?=
 =?us-ascii?Q?SKTXViN+H7MzSYb4Sp70Ll7socZyzqa3ms9VXx8dC9FxL0Kkj56+iIHXRcAQ?=
 =?us-ascii?Q?nyOaP6sO0IfIfP/upJ/KRA6LNXOrajnVbhqUgywwSCsrnHTjcnOi4m/iAUlf?=
 =?us-ascii?Q?aShF8QXbNmCjGb+IA0MtY8dspxCbFv9YrmVhf0pfyDVrQbZV7XXmtJd5GCsz?=
 =?us-ascii?Q?wRf/f5m/uBgmNZbfP0Lpjz9Ol6EPXEb/QEc7Bo+JB242Ukemu1to9ErDMqOn?=
 =?us-ascii?Q?O8aYLYAAltCHwyimcUto3HeVsPu/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2004.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97f789c-5c91-4169-b8ef-08d92c3f7936
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 18:42:17.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W6SqLxlSPiHF1U7Xw+UWdONHAg3gG7+bhdl7blGrMPUpgOic1sy+vC3lKt6tkU+9B+Q0vDCJtFDCavO9j1++4WEBkWh4FrSLP3PuW3q/VlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0891
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Sent: Friday, May 28, 2021 3:43 PM
> To: linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org; Michael Kelley <mikelley@m=
icrosoft.com>; viremana@linux.microsoft.com; Sunil
> Muthuswamy <sunilmut@microsoft.com>; wei.liu@kernel.org; vkuznets <vkuzne=
ts@redhat.com>; Lillian Grassin-Drake
> <Lillian.GrassinDrake@microsoft.com>; KY Srinivasan <kys@microsoft.com>
> Subject: [PATCH 02/19] asm-generic/hyperv: convert hyperv statuses to str=
ings
>=20
> Allow hyperv hypercall failures to be debugged more easily with dmesg.
> This will be used in the mshv module.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c         |  2 +-
>  arch/x86/hyperv/hv_proc.c         | 10 +++---
>  include/asm-generic/hyperv-tlfs.h | 52 ++++++++++++++++++-------------
>  include/asm-generic/mshyperv.h    |  8 +++++
>  4 files changed, 44 insertions(+), 28 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index bb0ae4b5c00f..722bafdb2225 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -349,7 +349,7 @@ static void __init hv_get_partition_id(void)
>  	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
>  	if (!hv_result_success(status)) {
>  		/* No point in proceeding if this failed */
> -		pr_err("Failed to get partition ID: %lld\n", status);
> +		pr_err("Failed to get partition ID: %s\n", hv_status_to_string(status)=
);
>  		BUG();
>  	}
>  	hv_current_partition_id =3D output_page->partition_id;
> diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
> index 59cf9a9e0975..30951e778577 100644
> --- a/arch/x86/hyperv/hv_proc.c
> +++ b/arch/x86/hyperv/hv_proc.c
> @@ -117,7 +117,7 @@ int hv_call_deposit_pages(int node, u64 partition_id,=
 u32 num_pages)
>  				     page_count, 0, input_page, NULL);
>  	local_irq_restore(flags);
>  	if (!hv_result_success(status)) {
> -		pr_err("Failed to deposit pages: %lld\n", status);
> +		pr_err("Failed to deposit pages: %s\n", hv_status_to_string(status));
>  		ret =3D hv_status_to_errno(status);
>  		goto err_free_allocations;
>  	}
> @@ -172,8 +172,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, =
u32 apic_id)
>=20
>  		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
>  			if (!hv_result_success(status)) {
> -				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
> -				       lp_index, apic_id, status);
> +				pr_err("%s: cpu %u apic ID %u, %s\n", __func__,
> +				       lp_index, apic_id, hv_status_to_string(status));
>  				ret =3D hv_status_to_errno(status);
>  			}
>  			break;
> @@ -222,8 +222,8 @@ int hv_call_create_vp(int node, u64 partition_id, u32=
 vp_index, u32 flags)
>=20
>  		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
>  			if (!hv_result_success(status)) {
> -				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
> -				       vp_index, flags, status);
> +				pr_err("%s: vcpu %u, lp %u, %s\n", __func__,
> +				       vp_index, flags, hv_status_to_string(status));
>  				ret =3D hv_status_to_errno(status);
>  			}
>  			break;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index fe6d41d0b114..40ff7cdd4a2b 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -189,28 +189,36 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_HYPERCALL_REP_START_MASK	GENMASK_ULL(59, 48)
>=20
>  /* hypercall status code */
> -#define HV_STATUS_SUCCESS			0x0
> -#define HV_STATUS_INVALID_HYPERCALL_CODE	0x2
> -#define HV_STATUS_INVALID_HYPERCALL_INPUT	0x3
> -#define HV_STATUS_INVALID_ALIGNMENT		0x4
> -#define HV_STATUS_INVALID_PARAMETER		0x5
> -#define HV_STATUS_ACCESS_DENIED			0x6
> -#define HV_STATUS_INVALID_PARTITION_STATE	0x7
> -#define HV_STATUS_OPERATION_DENIED		0x8
> -#define HV_STATUS_UNKNOWN_PROPERTY		0x9
> -#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE	0xA
> -#define HV_STATUS_INSUFFICIENT_MEMORY		0xB
> -#define HV_STATUS_INVALID_PARTITION_ID		0xD
> -#define HV_STATUS_INVALID_VP_INDEX		0xE
> -#define HV_STATUS_NOT_FOUND			0x10
> -#define HV_STATUS_INVALID_PORT_ID		0x11
> -#define HV_STATUS_INVALID_CONNECTION_ID		0x12
> -#define HV_STATUS_INSUFFICIENT_BUFFERS		0x13
> -#define HV_STATUS_NOT_ACKNOWLEDGED		0x14
> -#define HV_STATUS_INVALID_VP_STATE		0x15
> -#define HV_STATUS_NO_RESOURCES			0x1D
> -#define HV_STATUS_INVALID_LP_INDEX		0x41
> -#define HV_STATUS_INVALID_REGISTER_VALUE	0x50
> +#define __HV_STATUS_DEF(OP) \
> +	OP(HV_STATUS_SUCCESS,				0x0) \
> +	OP(HV_STATUS_INVALID_HYPERCALL_CODE,		0x2) \
> +	OP(HV_STATUS_INVALID_HYPERCALL_INPUT,		0x3) \
> +	OP(HV_STATUS_INVALID_ALIGNMENT,			0x4) \
> +	OP(HV_STATUS_INVALID_PARAMETER,			0x5) \
> +	OP(HV_STATUS_ACCESS_DENIED,			0x6) \
> +	OP(HV_STATUS_INVALID_PARTITION_STATE,		0x7) \
> +	OP(HV_STATUS_OPERATION_DENIED,			0x8) \
> +	OP(HV_STATUS_UNKNOWN_PROPERTY,			0x9) \
> +	OP(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	0xA) \
> +	OP(HV_STATUS_INSUFFICIENT_MEMORY,		0xB) \
> +	OP(HV_STATUS_INVALID_PARTITION_ID,		0xD) \
> +	OP(HV_STATUS_INVALID_VP_INDEX,			0xE) \
> +	OP(HV_STATUS_NOT_FOUND,				0x10) \
> +	OP(HV_STATUS_INVALID_PORT_ID,			0x11) \
> +	OP(HV_STATUS_INVALID_CONNECTION_ID,		0x12) \
> +	OP(HV_STATUS_INSUFFICIENT_BUFFERS,		0x13) \
> +	OP(HV_STATUS_NOT_ACKNOWLEDGED,			0x14) \
> +	OP(HV_STATUS_INVALID_VP_STATE,			0x15) \
> +	OP(HV_STATUS_NO_RESOURCES,			0x1D) \
> +	OP(HV_STATUS_INVALID_LP_INDEX,			0x41) \
> +	OP(HV_STATUS_INVALID_REGISTER_VALUE,		0x50)
> +
> +#define __HV_MAKE_HV_STATUS_ENUM(NAME, VAL) NAME =3D (VAL),
> +#define __HV_MAKE_HV_STATUS_CASE(NAME, VAL) case (NAME): return (#NAME);
> +
> +enum hv_status {
> +	__HV_STATUS_DEF(__HV_MAKE_HV_STATUS_ENUM)
> +};
>=20
>  /*
>   * The Hyper-V TimeRefCount register and the TSC
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 9a000ba2bb75..21fb71ca1ba9 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -59,6 +59,14 @@ static inline unsigned int hv_repcomp(u64 status)
>  			 HV_HYPERCALL_REP_COMP_OFFSET;
>  }
>=20
> +static inline const char *hv_status_to_string(u64 hv_status)
> +{
> +	switch (hv_result(hv_status)) {
> +	__HV_STATUS_DEF(__HV_MAKE_HV_STATUS_CASE)
> +	default : return "Unknown";
> +	}
> +}
Wouldn't this be a big switch statement that will get duplicated all over t=
he place
in the code because of the inline (and also the strings within)?

- Sunil
