Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A866768E55B
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Feb 2023 02:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBHBWX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 20:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBHBWX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 20:22:23 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021022.outbound.protection.outlook.com [52.101.57.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB8921A34;
        Tue,  7 Feb 2023 17:22:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2fAMSqBJe9po94jozZRE+F7QeTGMUYoCvAJ/JKJCdfIDPHXLn+XWvfM9E/oF2gbM8ytzESpg7V4EXLFs1DdbNYsP+MGo2TAk5JHhZxTTZR8hDS5c6w7dLwOWZtavU8Arz7tiYby/yL77PW3QKyBfomz/cSvr5wvO8Sgm7dCZCSFkq3Z70xUzRKGU+NY/iG7/kSEJRvNhFipOCXkhnawK+WmYXZDQyI1Ze38xAz40mrXNuCVr6dOWmV89dYpf95ftDXHHmKYae026T9mRVYgpsvg7+7QLJYVyZtwBq5+buCHRMduCYH8uDufdEJnFv0UWs1NaJGsDGqx8S8bAzX8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPaOquUYseS+tTCkFh073Bx9UCONj7NeGfdXN2UZNqg=;
 b=FzsHwyDoBHIfwtBPwYIc7eaFGzT5mo9wYseql5ROUayGZX7dpl4LIu7kiRWioloXG4zOxIRTlqvB7xjnjGmV9Si+tjPtHgzx7bjuK9vnb/xYuq6yeNe4J/EodT0V6k/+y3tUGZsiqf3JcISnU39awu4lFEoxse29Qh/zPwUJXo2FHe5vidIFLpEO3knOQ9gFiK7TlMTri+/nNlieNSwXp9BDcqgi7DkzPNQgpFGyKUWYUlvvinxfMDu+7KY5regvhVZTd5gnI9Aflo7SqWXEC3NaPirGl8AOAjnmRqfaf6HV5Wt8iTRPVN0VWjOSzcU/DhecQSA+u7aX7k9mWxYkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPaOquUYseS+tTCkFh073Bx9UCONj7NeGfdXN2UZNqg=;
 b=DHN61JtYxtpkCgyJUXztWi0ho4d+AhIypt7Vjib5PkfczH2VHyp/0yvmNLFN1Yn0I2pcBvrxra3j/PreyYeXQCZDwNfYC9DZOeD7qhNdza2gsWLi6dqr5jjjFh7psR6Wzaz1Ag87sr6Z4HL9RqHYg0uUGLxUuwZvwpYPainKLVM=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3422.namprd21.prod.outlook.com (2603:10b6:930:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.6; Wed, 8 Feb
 2023 01:22:18 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf%8]) with mapi id 15.20.6111.002; Wed, 8 Feb 2023
 01:22:18 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "dphadke@linux.microsoft.com" <dphadke@linux.microsoft.com>
Subject: RE: [PATCH v4 1/6] drivers/clocksource/hyper-v: non ACPI support in
 hyperv clock
Thread-Topic: [PATCH v4 1/6] drivers/clocksource/hyper-v: non ACPI support in
 hyperv clock
Thread-Index: AQHZOsjMvY/hUKz0ckKIRFPtEp88lK7EQdQw
Date:   Wed, 8 Feb 2023 01:22:18 +0000
Message-ID: <BYAPR21MB1688524B64F4FF7FBE7BBC81D7D89@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1675756199-5917-1-git-send-email-ssengar@linux.microsoft.com>
 <1675756199-5917-2-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1675756199-5917-2-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1b26ae5d-9efa-441f-85f0-851cc4922855;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-08T01:21:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3422:EE_
x-ms-office365-filtering-correlation-id: 3287eb8a-4dbb-4660-4288-08db0972eb51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2kgAjB0iEtlYiTm12njjLlW4npnL4JNvvwLC9AtMhhILcdarrd3MnrC5cV7fuXNDmH3FwCvxjYC3VSNA4WCivEvFqDk4vAXi04/5nPNeC5MoiSSIbwDA6VKCdDBW/oua1vICEeMiPqs2ktyZiWS2tJ3o+zStfMwWQuRkDlZmEiJ6xp1NNd/w9g8qwmykNMrlaQddjpWUcInLqX3DYvbfhVB85hn46im3JTj/b2eq/3paAuwX488hyJXJ13LXtSaOs32+nnf9YCAihjM0H5mss+7e+RsUzFXyhnoaP492xacEAVfrgsIy+jtMQLxhVJ8tLIZJ9HEbbKlmWj9qrMTtndMadSfPijxLpMIxLeUYvjdhJz4SeencaoXPH3gsvOlpdFMdkWqFGF0byOkZTmrO7aCQzo2MfDaxst1SKh+J+Cg9yTexRLeHItl4h2QgwXGMQAOiOkE/sgdLlms1+Q4l3grSQu29U0AhE0tY2p2lp0hmylpT8t70u18PNfcD3bNV2YOMqI2ZaQWBv/FXqyZQ4hd7D/JWVmHGUxrV6MyEqUbBuGAX2QiZ4eIkvv7dcCS/hVJ8sDh57Ae4+gP6Hjz+PGis51QszKBNCAL1L/xo6RiL/ch2RC2lw727bw6iYFslw46QlOOrczSoRYLDcvbjtVaKD01Y41+FeXvgC6lr2iWHFLt/D/QrHSGEbP5FbFbrrKUOfSLKqKkdVNtKDPQ1xmwbrcNUSv0PZDz7DXbTneVaEAn0A++6A4UAD/1aqpRhwSWCegyCK67UCcDEo4vz1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199018)(8936002)(41300700001)(5660300002)(71200400001)(110136005)(7696005)(52536014)(316002)(2906002)(8676002)(66556008)(64756008)(6506007)(186003)(478600001)(26005)(66446008)(9686003)(66476007)(83380400001)(8990500004)(66946007)(38070700005)(122000001)(38100700002)(33656002)(921005)(10290500003)(76116006)(82960400001)(86362001)(55016003)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/5ysBR1j5EzCUjO92nfxGpnxkg+xxDy3+o8P8NdAeHxefHIGcQCzLgOHhOhC?=
 =?us-ascii?Q?nceyFCO7qI953xu7nDjAbhIx9+BD9/99NnoShbrLOXkBBSQps7+1SJOeaHrw?=
 =?us-ascii?Q?igJNB5n9DgbW+SCkI9z0AGESXqxdHiGPqL5Koqt8w3Esiz9vdoqo+gAF4LSh?=
 =?us-ascii?Q?V+sHSizFa4JJ1bwc/HqmjR0WElCATnWYyIgWFyRWQxm5jcRoFA63nqPsbfOw?=
 =?us-ascii?Q?1VgK+zPWptUe1Rmo67+4Aiex/oQp6gaP4gW908R3BtjESn8Hq2FRG9NwSDKd?=
 =?us-ascii?Q?pYfnGCzdKWdJlZ09p1QW9pjFRun2VxxSYqrF0Zkdx/kM30yqeH8vbjxxZs5E?=
 =?us-ascii?Q?bEO0494vXHcKSMZT255CEdHYtS9kcIRflD2neLV40TNkAGLFkkCsYwpYeFaZ?=
 =?us-ascii?Q?ljKWvjzU2+pmudb8RUd/nXjzoxbqrj+mjzfP45yIMy5pL2s1tsVwycLz+37q?=
 =?us-ascii?Q?jAFwgDvGBkhuA4n1HKYH+jmcDE7RZ/wOg0JZWhA+4z2ldvbQ3ffrjvibBggK?=
 =?us-ascii?Q?7nJv2QfXONSKRSa+TfdypYU4Cphpezwh0dDh1FB3pxHEla8rqsboTLTz8jHk?=
 =?us-ascii?Q?GN26N4Sv04KKrHMkUlB5Vetd5hq3my9LgW/TqwOddrJPC2sjEls7hTRtxahO?=
 =?us-ascii?Q?YThuxlbXukcB5es8DX/tmBSgfRA5BkluWo0tpV38Kxr8cnN89QdJ7SAtvfAH?=
 =?us-ascii?Q?nZo4UD+zW6roaVamLTBSBGgE87sWJwoL511vUVTA8hXpYVbxfxaqiJxQivRy?=
 =?us-ascii?Q?wibT8yKIh7YcJllfGGe5TeDBM1dp8Y1Qf3IM6LNC/14tHflggqxfpxwvnwPg?=
 =?us-ascii?Q?Y0M5PnHdQCihOLqKEp6t9XY8aEL5OPXTuzoyvIEtwe3SCoGFQ+LdZWPgX5no?=
 =?us-ascii?Q?IWjjiKTCXe07Z/lEK0TQ2O4/fhRnu7UeKHw2HGLtZ73wG/shWBnB1uhxQDWD?=
 =?us-ascii?Q?2ox9jcNV9JAc+Hz625/AQZAHcsFV0xLYBEQCUwyd5FCcc+H+MGG73RsuHse7?=
 =?us-ascii?Q?mhxNYnk9rEtWnrcZJczQfs+pbWIAMj1ogN6/HrH+aHGSbCcIL92jllYXlf4K?=
 =?us-ascii?Q?BrrRHih3rd9cMfx9WEvP1Zz6gVdN2hv2KYa3zifEAX+gds0KtXKS9Q3SJTPT?=
 =?us-ascii?Q?lGekwQp4SA8Okb+boD6KlT+pCPYSrOGpV4xgmHWj3KekYW3/MGDctyYAKLQO?=
 =?us-ascii?Q?4CV01luN8YXw3TvtsoufX5wg9Qu+BJvAty7h6M2Bzseuqf5DCkM84xvkjy2y?=
 =?us-ascii?Q?mfx7xjhDvHboNFRxTQyU9S0GbB2VJxRdX4lfW5EcjiEQWdSqkZO7beUh1j+y?=
 =?us-ascii?Q?tBRavtN1CSJm8Li+YmTi5VfppQ5DsClNmXX+FRFjnyabDA+dDU4G8bInRQR4?=
 =?us-ascii?Q?226aVgTcShcZXyf8xCO0JebEg183+suhwMY+TeiNzPYTZKXYoWee9nduR1fS?=
 =?us-ascii?Q?x9oYdPgUEHsWJKRNf4xYMygIudD1NVVfC92dE73+0s50uqrq2/BYz8qevpdM?=
 =?us-ascii?Q?+s9PhUYacFiHo6y/fHs18sn6N4HG63f6emCFRbpgK504AaTseQY1YEGemOhk?=
 =?us-ascii?Q?JTzf7tQE1ma6SylQgA4K/gC+REur/xtiM2eFkDma/0ABR8eod3eLIVRNAHyx?=
 =?us-ascii?Q?aQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3287eb8a-4dbb-4660-4288-08db0972eb51
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 01:22:18.0856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSZgpuq+PzwWptwzhvu3AelTlw3ISTDwTfCn0kzoQq6OmW682SLO+yC/28hwoebVFcMDQUkaWsw2zcGMy24If0ycH4M8YOto32G44k4xtbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3422
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, February 6=
, 2023 11:50 PM
>=20
> Add a placeholder function for the hv_setup_stimer0_irq API to accommodat=
e
> systems without ACPI support. Since this function is not utilized on
> x86/x64 systems and non-ACPI support is only intended for x86/x64 systems=
,
> a placeholder function is sufficient for now and can be improved upon if
> necessary in the future.
>=20
> This change will make it easier to add device tree support for VMBus in
> subsequent commits.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/clocksource/hyperv_timer.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index c0cef92..f32948c 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -49,7 +49,7 @@
>=20
>  static int stimer0_irq =3D -1;
>  static int stimer0_message_sint;
> -static DEFINE_PER_CPU(long, stimer0_evt);
> +static __maybe_unused DEFINE_PER_CPU(long, stimer0_evt);
>=20
>  /*
>   * Common code for stimer0 interrupts coming via Direct Mode or
> @@ -68,7 +68,7 @@ void hv_stimer0_isr(void)
>   * stimer0 interrupt handler for architectures that support
>   * per-cpu interrupts, which also implies Direct Mode.
>   */
> -static irqreturn_t hv_stimer0_percpu_isr(int irq, void *dev_id)
> +static irqreturn_t __maybe_unused hv_stimer0_percpu_isr(int irq, void *d=
ev_id)
>  {
>  	hv_stimer0_isr();
>  	return IRQ_HANDLED;
> @@ -196,6 +196,7 @@ void __weak hv_remove_stimer0_handler(void)
>  {
>  };
>=20
> +#ifdef CONFIG_ACPI
>  /* Called only on architectures with per-cpu IRQs (i.e., not x86/x64) */
>  static int hv_setup_stimer0_irq(void)
>  {
> @@ -230,6 +231,16 @@ static void hv_remove_stimer0_irq(void)
>  		stimer0_irq =3D -1;
>  	}
>  }
> +#else
> +static int hv_setup_stimer0_irq(void)
> +{
> +	return 0;
> +}
> +
> +static void hv_remove_stimer0_irq(void)
> +{
> +}
> +#endif
>=20
>  /* hv_stimer_alloc - Global initialization of the clockevent and stimer0=
 */
>  int hv_stimer_alloc(bool have_percpu_irqs)
> --
> 1.8.3.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

