Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF896DE27D
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Apr 2023 19:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDKR2o (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 Apr 2023 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDKR2n (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 Apr 2023 13:28:43 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021025.outbound.protection.outlook.com [52.101.57.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B339130;
        Tue, 11 Apr 2023 10:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUPEyuCu5RD3CSOTsxG3fGVe9NDPKmOeZI+ry+YwWItudnYWozCBRdCyMHyhplJM157rNZi6nemvC+nBstKSfW+mkt5jGNlWZAdfGyO0uVXlhgBjsepMI3U6eAuqsCKxSLktSATjPaLFLli+BjJJIOElE3dy2eyspJegsZR4p6x7mp5UZEHFlmFDk0NibijivvLT6fNHpxIzbBLvBqPU0yBXvP7rrQWrZ5y/k5omQ10dpjrykdB1SxY9S+bZD381TNO/EqW2os0t9aUdBSMXhzqRJcS8spQdpqctVZlSt3l9yGfwSFzGPtt+tieMXvqMxyQgTN2RtT1/KCB581hL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjidhPRpjIrweWjqJ2Y2T8yxo/W2X+egcklxWeKa8/A=;
 b=k4VJH8fRsOYtgt8SZWWMobn93iS78Os5wQnyLDk0ZZuAF5GW/RSfHt7dGuZPt9Gu8mBtUNvg9gJ65AafIDBg1yzszZtDxZqqAmlGbowCTu8o+cIo6f4Dx8XUYUV7eH2QB+SBqbIZ2G6VPVA1ZW+f1Fbbd82E0g9YE8eUjJ06Sg531MuVz+El+nmgAeqnmYt0GC/C63eBucOT37f6NkSSv0aVzC0I06GGEKThnw1VxqGQJHZ2dFPSkMVGC/SV5PDH64uwZeGh4NEdKGrGUkZ85MVyEPDYSrbKuho9L9HP8Oc5X1Q2ULjdj0OdFs+UbgQYQrVufRLamzMuWI8kBn6jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjidhPRpjIrweWjqJ2Y2T8yxo/W2X+egcklxWeKa8/A=;
 b=UMEDOZAHRjT1W4qPIIndoCtFFYGrKUPb5QWkQbviKn2Y0snBieMBFIiq5lbbp7SmH1bQvkubTgoErpEd9qMR8XIXYkKJUJRlOlcBbCMD59iwt3Uf/oCgHS1JaJac3gI0S7ggB2RqLDzRqIsN3Bp6mHDe2ykr6ht15856jFgUWbU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3774.namprd21.prod.outlook.com (2603:10b6:8:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.3; Tue, 11 Apr
 2023 17:28:39 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.003; Tue, 11 Apr 2023
 17:28:39 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clocksource: hyper-v: make sure Invariant-TSC is used if
 it is available
Thread-Topic: [PATCH] clocksource: hyper-v: make sure Invariant-TSC is used if
 it is available
Thread-Index: AQHZal2t+gXA9GFjvUyKGgIEPApXXK8mYShQ
Date:   Tue, 11 Apr 2023 17:28:39 +0000
Message-ID: <BYAPR21MB16884AD46D83DB91CECB34EED79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230408210339.15085-1-decui@microsoft.com>
In-Reply-To: <20230408210339.15085-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0408b8e5-b364-422e-861d-2b4015d4843f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-11T17:27:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3774:EE_
x-ms-office365-filtering-correlation-id: af235e06-4c50-4fe6-4f87-08db3ab2309b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vchxXw0qEO4Dmt6m2ssM0oYLk8DwSrOojjWVV+1dk7nsxM4A+OYy5aJ9deLwXktIszwR89oyzILbCTCj+bmN7Lc+7N3mSNx8QPWLzG0OVY4gUwWvoLFo1BCdJoGjoIB02EGn30wjIbawKKxBXZ0xyeYW3E68BOzPojof0thw8gaVh5YcMjGwNrBxgU3kbcywHvriCUfz3dJ8ulq+rI7Tc7huOd/sho9ildleknX8PCswmHRWwq15iiNVT4Adjjwm6z4d/ZLHIFplEqjs+yXNLOvFvBEv7KbYWpUxG2s/wxU6eBfkk7hHczECQGQ3PRt1ZjEhWSgVQBKUJYcvl9ggcW+iChyjYZ722vELKnXl5Ge7t0I7JLv5EmDU1JS6GpHqOpVloSxn1dRTAw4CIbgSGtVDQ7me+yapdHbqa9SmP5w9j+8qxGBjFRmclqXbzyNGQn+WxFcp9bT3pd93E5dRkUWY3EjzDNu8cst6uxadmK6JaxA9DmdwLbICcz2Th9IgrKL/rm3N4tLuslEpn/iUEMPOSgdB4bHRA2+HmaQZoqg9rzEbA9fpK38ZdW0f3ymsLZQ8dAMmBVGYrKE5By8Bvc+LqAf82d3P/eIWAkHD2aBaW+S+aVrD5KYVZcUQHFuztVYlKAH1013p+R1+zDZjIGbVVv00Dc0EKAru/RLUo0M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(110136005)(8990500004)(478600001)(10290500003)(33656002)(82950400001)(82960400001)(38070700005)(52536014)(5660300002)(8676002)(8936002)(66446008)(64756008)(66556008)(4326008)(66476007)(66946007)(76116006)(41300700001)(316002)(786003)(122000001)(2906002)(38100700002)(55016003)(7696005)(26005)(6506007)(9686003)(83380400001)(186003)(86362001)(66899021)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Me3dp66c33vdot2BAUa7nOwF+SuIOVf5+Z/V1IRKk/B/WRVx4l7ZRtIKafGL?=
 =?us-ascii?Q?VzZy9i1grHGrmEeSy+mUXtNV+Cky7qSr6pb1vQhy+Qz2rs/wDoP4EZ/s7gXK?=
 =?us-ascii?Q?Kq5DlKAkvRF6usVBCkG2HJUuTOnBZndpe2YtDN62+u39d42EBnz0tJkgsAzL?=
 =?us-ascii?Q?9l4+J1VM+SFzwxlOnhYPGUWeaBDvwwxF3sl2lGesCRjpfqJG8/btA8juqY4v?=
 =?us-ascii?Q?x9MRJjFzmd3Z9RGbiBLciIMbpDdKe1cWWJWHIzA07yalKnUPSRBIDsASU2hz?=
 =?us-ascii?Q?J8ZacWPG74+9sM4gE9Re1HuCCaU4PgDG/JAeyUcJA2csoKXYJMoMFYNZIc/j?=
 =?us-ascii?Q?akhrAlCt6IF4CDenTC/ZL2lsnuF+TL0skkrXbUJR7zEt0WYjEXCc/ZUVMqyj?=
 =?us-ascii?Q?NNCmoAMa0m3sggOzzTeuVCd1yMMO3lJa3zh5cS9z6PSVW+YBnvOcOGSzHc57?=
 =?us-ascii?Q?PWoFmzfIJMsFbI2okn3+05vV+ABXLXepytKpZ6ZAmUhQP2A+TO+RnNd8yzA1?=
 =?us-ascii?Q?Uw/lLI1QfWc0QoHr5JYA0T56LXiQVwZjYk0wNNugEv6PlL8VEW9R9g9+R1RR?=
 =?us-ascii?Q?xeZsqD1svHEc7JhG6b5/3seeuGhQarAJRH4c0wDgGQeGxX9wgIK5U0g7GUH9?=
 =?us-ascii?Q?dD95R32jEfiVVhddfQ1WstvJ+HhqJGB+5gEiiqlsxON/DgHxGL9RjR29H5K1?=
 =?us-ascii?Q?5fsVdrMdISB+B+C/KheAqpGROnf0nC0nJIINKeEwqYdTxUhxIFg2j6IZKw0g?=
 =?us-ascii?Q?JUSPbltIbtSwHq/tZBTAnwZqnPEln8hXhrfZGbDOahuQnUFZ880PhuRfxwkv?=
 =?us-ascii?Q?yTzqPYfa25/5J/xXaLi7mQc7yyNXe2UOdLEu+OZJG9vDxdllN0PlR3QI8ygw?=
 =?us-ascii?Q?g4U8P/+5sSaae0/0BNJxvN4EWGl8SlilWhoHspB2FQgBF0wHDrUBEuOVen/m?=
 =?us-ascii?Q?ajoHPtG48evCtlMbKv6/s16TL0NDh+uzsr5GWX6quE4+WVxP+iOOr2h09jJ4?=
 =?us-ascii?Q?kErIDI0y484icnwuUNoaRWx4L3qUZvpnA47SasgbxtDgAV0+Anc1pKVPkDG2?=
 =?us-ascii?Q?kGFO6owEi2v2FKemWUoUdXNyClm01ZXzE0Fo6T/g+dNvujO9X7t8YyHIRhrE?=
 =?us-ascii?Q?oqVN0GcMMvocAFuYMQ7CttkgfhPzeOLqryrr3PzuAwObYp6E/WZyrA/H2kQI?=
 =?us-ascii?Q?PdPFRQZ7lyET6NJWxjA74NGZPfDe9qniGsbz1r+mlJVGEQwhhJ+67VD1uk9F?=
 =?us-ascii?Q?X3DEpsYOtPPXM5sgmauZ71Tmvgy5188njwSnu0dqVmDAWFuy0Ox7qFR8qG+K?=
 =?us-ascii?Q?A/Vsp27xXsRN5elKNuxYJ+klA+EbmRH/Auy5ifAFqrDlIaanUBFg8I8ssIBe?=
 =?us-ascii?Q?9nEkNwE7D2deCj2ZvX1CpZ9S0bw1Q3/PaUGufA65dUt39ObqJNmG4MTujt/c?=
 =?us-ascii?Q?jOqWF7EklUJ/QUCmyeMLVdqSPZpIkoN1yFmyLMA/SoF09ML3FIEwq4hzEA2T?=
 =?us-ascii?Q?U8i8nyrmgp5Qaj+A3MLLdrEPddU2cx15JlLm1NLi7DnxOR7Sr3yURCaxVYvD?=
 =?us-ascii?Q?5Bh02xxZ70NvI13Pv32eU2Ros655QIRTM7omJftcAKSx7AXAknvwnMwwaDcO?=
 =?us-ascii?Q?vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af235e06-4c50-4fe6-4f87-08db3ab2309b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 17:28:39.6750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D1aiFljnaQDPuVjxpQ6I9hBnf4M3Tc0ANZSMmvjPSpF7nC/5s0ZaNM1+Ruo1SaG0/mL3ReOZpP87NUKdn61DcCR6JWY46V2ZeSxQq2WRucg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3774
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, April 8, 2023 2:04 P=
M
>=20
> If Hyper-V TSC page is unavailable and Invariant-TSC is available,
> currently hyperv_cs_msr (rather than Invariant-TSC) is used by default.
>=20
> Use Invariant-TSC by default by downgrading hyperv_cs_msr.rating in
> hv_init_tsc_clocksource(), if Invariant-TSC is available.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/clocksource/hyperv_timer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index c0cef92b12b82..7901a88ad9188 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -506,9 +506,6 @@ static bool __init hv_init_tsc_clocksource(void)
>  {
>  	union hv_reference_tsc_msr tsc_msr;
>=20
> -	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
> -		return false;
> -
>  	/*
>  	 * If Hyper-V offers TSC_INVARIANT, then the virtualized TSC correctly
>  	 * handles frequency and offset changes due to live migration,
> @@ -525,6 +522,9 @@ static bool __init hv_init_tsc_clocksource(void)
>  		hyperv_cs_msr.rating =3D 250;
>  	}
>=20
> +	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
> +		return false;
> +
>  	hv_read_reference_counter =3D read_hv_clock_tsc;
>=20
>  	/*
> --
> 2.25.1

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

