Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745F942410E
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Oct 2021 17:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbhJFPRR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Oct 2021 11:17:17 -0400
Received: from mail-dm6nam12on2116.outbound.protection.outlook.com ([40.107.243.116]:28672
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230436AbhJFPRR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Oct 2021 11:17:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8wVcRU4gshV3sT2MWN2oxhuIUdTk/79Kvw0sQFnfuBqkf5qIBOwjWUkyuNtjWM8oQ/IaJW8leVxoVC3a1cFHB4N1ev74vcPWUAyExObc2FrnCXmxGGAumAhPPr0suUed19tyiEdt96NMG4nqrzV3Onw6MHSNGlv2TgpQkOk6PV6oNT23sr1fyO36P/6BNRQ+LW0/Y9ROqTsZbsCXD0DIeOQPXWeIZJ+rMmCxCOk+utuRBLkMwSn50zxSN10me6jPh5n+etdHLy6P720/j/eYqkFLu5Y9TPoIdmOmZ5gztxENfIIkVMRySiI5EgU+JhEgQrNLUUfitd8DD02HsZLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Am0E5CEcSvl391w+mXZ6/S2TaHQAdA5hWXBncF+kfg=;
 b=LyOVu/xGQSxv+EXj6oTd0ycR/WJi+bLno/Q1pBwj9UlJ2JqSmjbKLjsiXpFHs7vctHiRkJ+7QQiyY76tymHDUUqFqsNYVgR+kaSsmmGx39taNbip1haF7Lbh6U5O1jlkuYkL/SGe/tu/Ozblp0oZp/Maq3H2YjgGUBoonZJ1uSQp7Belv3q/9u8iIHL/k5g1chWAC2wEqvCPKqEA/iXINkyfPjIDKTy6mUXHpSQOx9XWVjdv11C2Mb6dqZ10+WAm2zpByAySFwo09+AJoq55tGnzEDRnHrBgbQnlEa8jEL9Pe1aeo0zQPbSMSowU1ZdZM2gqMHafRusHjrkt3ayyfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Am0E5CEcSvl391w+mXZ6/S2TaHQAdA5hWXBncF+kfg=;
 b=T0vBj8CfmRtPkSUS+8XNDHGAJaVF1Zj2nBV1abThAHB5fWLgdPjfwuX/K0RCpTASX3T9CUGrTdB/rBpeQkhdWR+k/dWA2zJSvq2Dt2P6gOyr5DPncqg3t+V0Mn1X80qB8u8rTvtlpOmekbIycMGhZaKe3HfUtiooO2T5anE/Cb8=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB1548.namprd21.prod.outlook.com (2603:10b6:301:7a::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.3; Wed, 6 Oct
 2021 15:15:22 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::6129:c6f7:3f56:c899]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::6129:c6f7:3f56:c899%4]) with mapi id 15.20.4587.017; Wed, 6 Oct 2021
 15:15:22 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] x86/hyperv: Avoid erroneously sending IPI to 'self'
Thread-Topic: [PATCH] x86/hyperv: Avoid erroneously sending IPI to 'self'
Thread-Index: AQHXurC9kEm9S80mEU+wnpeh7MRASKvGFE7Q
Date:   Wed, 6 Oct 2021 15:15:22 +0000
Message-ID: <MWHPR21MB1593E25D205903BC583C395AD7B09@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20211006125016.941616-1-vkuznets@redhat.com>
In-Reply-To: <20211006125016.941616-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=60dc443f-f38c-4c0b-b34e-d763e579c331;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-06T15:14:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0ed3694-4f67-4126-4bda-08d988dc1db1
x-ms-traffictypediagnostic: MWHPR21MB1548:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB15489BD9B88E50E1405AAF05D7B09@MWHPR21MB1548.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2pKjUNapGKTp+GXe6t4TgdkXbQpoHZHjtyiLngUURUvLjPkI84TOXhhFgctBzfeo+mBuVFm0HGai3qoYZAPSalZrm9APZROG/qFMHzEVMeQuQ+F0Dxmz9JuCPFz0sxtDaZx4u8DqxV505PhNU1XkrUh5u3UDDMI3ebXMYnOK8i6+jwOXwgeDI79dII421T7gE19kCaNVMxFALqmKI/J/Oppi2yOTi9UTLCnfJMIlfpUp3eIgE7aQcGodKfGcKwMopNlLP0cxkl2ZqLMdtFBC54zTlJyDtq6X82jtgl8D8R9ALRkUSVOSXzqCGrZ+tCU9zHLw0p1q09vzYUpQFvkI0SLEm7pnLs033rdKu86V/luT6ADP/JGULMln8ZxuzVNizFGMpQzY1MymZncYKQDYoL7344EETvh7hADPIcziOihe4CC8auTPT9xOUgSq/fddwI3MaMXqWZmZOWRLcZ7Wb9cEoKT4hMOmbIU5dvYO7Y38OLXkGFLSbaQSr1Tsz8KZ4yoVnQ0c3SEJJejV6JtGSbyYDu202bZ6cu4WTBk8dIglC13q0uAp8wN4oVCcXyqgzLnbK2wCbyXiw0UulNlb/yWiRGJ0IWjKJIgtHfoafTIijdp/0UFcqxIzMNjjsU6/q88L39b3qauSXIDG+1Yjkr/jsMOcXU5RWcibGpWeSklhIJACKwN1wYeSJq5RbRywmzKpQaq68mdn0MrOVNPAzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(83380400001)(54906003)(26005)(5660300002)(110136005)(316002)(52536014)(8990500004)(71200400001)(107886003)(8936002)(6506007)(508600001)(9686003)(10290500003)(82950400001)(4326008)(2906002)(76116006)(55016002)(66476007)(66446008)(8676002)(66946007)(33656002)(82960400001)(64756008)(66556008)(86362001)(7696005)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x2RUsFnCfgCRVCjclNhjgVJudKCbxvzqjCpmBoxzjrf+cazwk0g1nobUpv//?=
 =?us-ascii?Q?E2jIMf3QS/ta41+WJh9AIovsoJYNqOA23M496n5GDVPJe6Ts9D4vPrS7rTCu?=
 =?us-ascii?Q?YszpU9m4aGVcGXD+064OPAo7RxiSGA2k1VxkcWjJu/mVT513ELMVJExVUAUu?=
 =?us-ascii?Q?4VN9vlqvxZOzEXSgDnbCMIE7y9V+7clHSK9H5f83nCCsy2yrLt9VdSkREHTo?=
 =?us-ascii?Q?s/05maq4TlGL78bi7hZlRuGsW5vzFlsetyO8KP8I/0z0GSfO03aghZXEojJC?=
 =?us-ascii?Q?oRU8Ow9ctvaD9ZIq93PWlhGd4j89MKCNjMgvMrFl84d86pHj5eGsUsaM8UkL?=
 =?us-ascii?Q?jw5xnNOoslFs6XAj1p6VS/xsx0ncovwuky1zuo3DhcKMiP88vIOpsN6C3WXT?=
 =?us-ascii?Q?/4O/6rORUHFXkSJvZEmPn1OTXY4qaPgNjiwY3JqXiAkSsOp7WZXVmfL3SUql?=
 =?us-ascii?Q?G4IGXDDktsu04YHGkkCfeI5F/aeO0lQ/wHy41xilzt0asowWSa3y51UbggtI?=
 =?us-ascii?Q?iwD/Ef+mal49vbCi85FQvPf89kcBzHwN7yW/AiLUDYQYj6Yjaxewe84j/BiK?=
 =?us-ascii?Q?oz4njNt+va4iBMY5fmyA/2OcHNGgCMcdkPsXj5FeKOA7pAxE4X3y1yJZwvd8?=
 =?us-ascii?Q?ZXNnObPBUMef4FOk/C9YOMg00J46Wm6MF/2EaQqGcx4tidNS+/oHkfbUyB5H?=
 =?us-ascii?Q?1HN2wnjW9WwdGyaZ/QYwxSQ+j6qNROoEfgfphYdeVUX5RYX7Z+CCi3zfRIe1?=
 =?us-ascii?Q?KPj1bv6J9C85bVBbC3+ONm7YzZN/OAALEWLKmcQkuMj+6kRRGyNw+v5jGJF2?=
 =?us-ascii?Q?wuTr7+7kVCq3oHX8WoGp8hundQWH732YQRCJo1KhE1beU+DaFQXvMmhuo8lU?=
 =?us-ascii?Q?QJLpP+hvvl+jJyq/BpHOBj6zPXOPeNH3QsNLLu6kRdIE9tUjGJvjUZ39B7tn?=
 =?us-ascii?Q?wjTF+Ki/LM8QAKerdfM6nSqRhZ1JDh/CxiiUVTWZTjthn7KV/wbWlMrj+jGl?=
 =?us-ascii?Q?+f4bCVEykKRDhrmzXIPcHr8OsI7rAODmPlCu/HrCZ/cz/O/leJrPNbZksgEx?=
 =?us-ascii?Q?uX9y6IUMQoILJSxuP1iz3hLh3NHDS2LnKQXT1qGT5eSnB6mw0QzIOT8l/W4u?=
 =?us-ascii?Q?m+w1xlU+uOdcdCVv5a/+WHVHxa1yunUZIpw4jCajVCj57qNkc9WLCmJWtEMl?=
 =?us-ascii?Q?vjisdOtDIfG8s3abTKGrVlNi3GAzVAi1vHiUOkxEdIC/TT/u8XrP5n/eGWXW?=
 =?us-ascii?Q?1Nnmy7b6TBuGxlzjmGucOXySYdEi6wPAPjUO18tKhOkAthefd/Tj9jca3I7T?=
 =?us-ascii?Q?35OYQh3aCkeRxgzGWkSek1S8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ed3694-4f67-4126-4bda-08d988dc1db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 15:15:22.0557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfJCJJ16vhpbZh2EyFYXxbkKnaigCALIWlk4hD+HU1uM5rdceWu9Z6gPN9hiMBeCk1OeC94ygS+V+xeJJIBvbrCrbFeFpv5ioTwVZyzEMrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1548
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, October 6, 20=
21 5:50 AM
>=20
> __send_ipi_mask_ex() uses an optimization: when the target CPU mask is
> equal to 'cpu_present_mask' it uses 'HV_GENERIC_SET_ALL' format to avoid
> converting the specified cpumask to VP_SET. This case was overlooked when
> 'exclude_self' parameter was added. As the result, a spurious IPI to
> 'self' can be send.
>=20
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Fixes: dfb5c1e12c28 ("x86/hyperv: remove on-stack cpumask from hv_send_ip=
i_mask_allbutself")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/hyperv/hv_apic.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 32a1ad356c18..db2d92fb44da 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -122,17 +122,27 @@ static bool __send_ipi_mask_ex(const struct cpumask=
 *mask, int vector,
>  	ipi_arg->reserved =3D 0;
>  	ipi_arg->vp_set.valid_bank_mask =3D 0;
>=20
> -	if (!cpumask_equal(mask, cpu_present_mask)) {
> +	/*
> +	 * Use HV_GENERIC_SET_ALL and avoid converting cpumask to VP_SET
> +	 * when the IPI is sent to all currently present CPUs.
> +	 */
> +	if (!cpumask_equal(mask, cpu_present_mask) || exclude_self) {
>  		ipi_arg->vp_set.format =3D HV_GENERIC_SET_SPARSE_4K;
>  		if (exclude_self)
>  			nr_bank =3D cpumask_to_vpset_noself(&(ipi_arg->vp_set), mask);
>  		else
>  			nr_bank =3D cpumask_to_vpset(&(ipi_arg->vp_set), mask);
> -	}
> -	if (nr_bank < 0)
> -		goto ipi_mask_ex_done;
> -	if (!nr_bank)
> +
> +		/*
> +		 * 'nr_bank <=3D 0' means some CPUs in cpumask can't be
> +		 * represented in VP_SET. Return an error and fall back to
> +		 * native (architectural) method of sending IPIs.
> +		 */
> +		if (nr_bank <=3D 0)
> +			goto ipi_mask_ex_done;
> +	} else {
>  		ipi_arg->vp_set.format =3D HV_GENERIC_SET_ALL;
> +	}
>=20
>  	status =3D hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
>  			      ipi_arg, NULL);
> --
> 2.31.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

