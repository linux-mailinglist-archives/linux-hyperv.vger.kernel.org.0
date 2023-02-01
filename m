Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24C7686D5E
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Feb 2023 18:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjBARrv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Feb 2023 12:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjBARru (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Feb 2023 12:47:50 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020027.outbound.protection.outlook.com [52.101.61.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFD47642A;
        Wed,  1 Feb 2023 09:47:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEd3TSw89OKUdaw2fBM/vDCqsm9YaaN2dbyVtobV1GoM5vXi+cmxfjmmQlF3izHKMOYpENUeeXublfr8GUVxCAzRR3uGu7T/ATwd6Q9IKHvNQ6eqY8m84BPHau/vT97j37Ad13z2Kyp2AolG7AhSxt/Y7MdiQH75aaK1f67qs1EoQ2DF2ztJOtRXxzf5wI3ibraQGmeFfAFVa8G4dTviuhJR2FFZgIhcDH4jPLmkGU0taO1bI5gSnBCYixw/xyb3uOYtThO4WgzCezauRJmpba0IYs891+iV4yLlnhE20iGDj8ZcC68PepMS0t8lSHrMiZdsRiLhakizkUggAKIhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Z8N5jUJsQCSI7/mf8iOw2EgT0wUbhCPKlp5gLNzqD0=;
 b=ZeWbfJpoBXqKK8f3hpHB22ovig7Lpk/l3wSzDdzpYKfUWTCrheE4I/eX8GbmJ5mGlwlDn9nL9hHjv4XDyS0wu5EsVLF9IdWtIOltoYCW5vu2tqQ81+SXL+uJm62y+B4kt3fAVv5RqnPd+6Urnd/RBXgheQR/CzFI2v13zguj1qdJeTgkTiz2oINAEU9xEqWJfzshUmcmLPibi7T+e5viMIfKXIl32LbjwkvueLdAjaukbfy0xq5qj05zStvfmjYZcaZEkmrcY+xv4qwpEqcw/E2tpoN4Sz7N6dwAo5FdPATj4XBaXOJo+cU+KoUnYHwVzXZyF3kRRPSHS540BGViqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z8N5jUJsQCSI7/mf8iOw2EgT0wUbhCPKlp5gLNzqD0=;
 b=HPhL1Ivael++Wpr30iE0iH/khhxwVx/37Nqe4R1ymyOnhzGeI6R0FbmTslYx197Kt47yDlj/uhwFZh+oBFBiJU2ZdwhCXNYYW7eAmlNILJBOj26egassXx5k4JJZyKe0hAs+8L5D9899opS8weyg9OnuR5CPdXouBFiAcuIDKi4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3376.namprd21.prod.outlook.com (2603:10b6:208:39c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.4; Wed, 1 Feb
 2023 17:47:45 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%8]) with mapi id 15.20.6086.005; Wed, 1 Feb 2023
 17:47:44 +0000
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
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH v2 2/6] Drivers: hv: allow non ACPI compilation for
 hv_is_hibernation_supported
Thread-Topic: [PATCH v2 2/6] Drivers: hv: allow non ACPI compilation for
 hv_is_hibernation_supported
Thread-Index: AQHZNZ9IFQFykaMu2kK/hQ0cFp0eSq66XU6A
Date:   Wed, 1 Feb 2023 17:47:44 +0000
Message-ID: <BYAPR21MB1688813B65EEDB79554E30D4D7D19@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-3-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1675188609-20913-3-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e08188c9-4968-4e79-9ec4-2695debbbece;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-01T17:40:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3376:EE_
x-ms-office365-filtering-correlation-id: e7e75fa5-f27e-47cb-7fdf-08db047c6c7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fdBcOI9H2FPRStwCP1Am5sYEhaiphPdzPu3tdf+kJGrkR4kJL/Q39PGaok/nji/YpMU7SbA31jZWGp1wyX7Zr8TC9VMxqI7lVQt4cUyDSdWM34/SQd2+2KhfVEJX1VTplKVcnaNYQEZwYA1AplU6vHLBiA6hnvRJ0JoaOUNIKJbXfpfnpHkAWNvQAQnG3bZTHw6HW8aWpl09ezBt7b5zFWdF3T5vofUDbWAdBFkyVUmEedX6cxz+1GQOk/tQUo8mVrASsVwNTfH2meMg/1FzkkzGKiosK9605dvs6Tq5156mxZcUsF17YP1QJ4N1uVGH2y7kFmFc9iLvAac9bBsm9IB5e6xBzNGfWhxZ1DH/T9RS3yyQRDZDW3I60D+12luw59IrbOpFPz/biQqKR6BHsWMJhjmddA0sTOyTZw4muMHlLndv9eoX7PncQJBdw/kQdDaGtJ/58fIoPAXHloss8qptJZTf6j91Hgdl3Qv9P1gNo5pw/IThxw38CefRXmm2ucy5Ogukyc7rDjddOFj27r2Ye3OOo3RVKu60S3Q8MHEA1+6T3XvWovjintnDSy0tzSqTLR9+eD7Iy54SbWI0wo1MgdE5ebnPs0Rjk7/loXr38QFYg9YHIcBpBKi/N9foj/WErr1xibGH84lFf9/PbjQx0We6Yykni576osxmjZjxiwBcONohtIH1tL2sQxgUQ36ric2AyHVlsh0iyxkDp8/+SN8OGCR0ddjRxm4pfvZ19nsJ/P021tXxeo9LUWgYvz9ZMeCx+6Fo8rlyIW/zbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199018)(5660300002)(2906002)(8990500004)(38070700005)(9686003)(316002)(82950400001)(82960400001)(55016003)(921005)(41300700001)(10290500003)(122000001)(6636002)(110136005)(66476007)(76116006)(64756008)(8936002)(8676002)(52536014)(66446008)(66556008)(6506007)(33656002)(86362001)(26005)(7696005)(186003)(71200400001)(38100700002)(66946007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yWLge41/+ME8xuI1cRL4IP2d5c57QE8EnE8ABxXq8WiSvyo9oo5+uS5uK95S?=
 =?us-ascii?Q?5ekjcxHrmMcc21+Zh/Ehl17sNXH6oSbfm+K6dW38QQTHP+BLu2cQLrc2/SLm?=
 =?us-ascii?Q?4LKlyogrUNpncgKNxk4WYbNoiNcSgX6VE9ziIfuY/GLSc++EPyEni2LoFElN?=
 =?us-ascii?Q?NEAlFFH26nby67S/TgTjWVSChTWlv0XiLdper/8HRHbDbJQfeh0NOCF3EA1F?=
 =?us-ascii?Q?uItvhUNQdSRRrNTtw/v1aYLzZO/lN1EW8VjWJejNxBzX7yPummvp5ON5EE5g?=
 =?us-ascii?Q?qywbcVCBh/J7intbefBP1ITp5ELHaLK0EwgVR3MyHsStj77YBHSa+3JlPtZH?=
 =?us-ascii?Q?ouV5pm6P12K2F9wND4bVebmAicerpjEJ8BzQ+WLhg8O+qgApTloiL+Bf+wEh?=
 =?us-ascii?Q?LCAVIZwPjW1EbzDSUkq3EI2Ej0axGOjWBeQmVI36ADhMK7zXwe1+4ZNkvkYI?=
 =?us-ascii?Q?Y9SLKsf+/up6yUlt1oRDjM4Xz7VMtyrwQ9wZza79C/lwezu+WDnK97uSbOfl?=
 =?us-ascii?Q?jWIUDWVJ+x9eBmq+FyDwuzIzYRfH6HNlM1fPQi/On401H5f2UAxDRWrjvrZq?=
 =?us-ascii?Q?otmAwRO5xa6kWqqNCHewcnQGqg3G2rN4VK0p4lWv5vh1H5OErC5FeONAsUeo?=
 =?us-ascii?Q?ZdLByeb5iFMNqHo5U6jaGDqla4qT+iYwRIHwXwIvrHt6lAJKvPt5kDjpooE5?=
 =?us-ascii?Q?G4QCmk1FyvK5/2fO3pGhsU12mqcIlo4q1dQVS2OnILunL1B7oS05X1/zV/aq?=
 =?us-ascii?Q?S8tAdSbrYWrAO4x6EOWRNn7nUZhSLsRNI9TXb7TH8ImGkCXU6XVFIpetD67B?=
 =?us-ascii?Q?CoPgxrf74A69IoGSOxqPCDxpAPW+HmRBMLd0qPpuZy5VuEhWbhtIhpka0p8d?=
 =?us-ascii?Q?OX55VjQe0CI+rT0lYz1wnijCFJ8fqRoMfrEFnQo/g+4HdWOdL4IXnyde8sV6?=
 =?us-ascii?Q?rH0qwhu/mpwmOYYRrv1j3exZliLSDxhtga3is8Q8vXrSoYgwo/ja+4vdpFqc?=
 =?us-ascii?Q?Iv8MH7Ubr88M91KM/xo6hwpQsJ/45dTPXHhc1LTM+to2X972oZfr25li6Kme?=
 =?us-ascii?Q?PH2zaPSCHt0lgFOxdzkvFbbFyXghN/CumwKc4UVRdtFoKu3W34AneeSnvCIl?=
 =?us-ascii?Q?PaRGUKBN02e4MGf66Y5hhGHfJ7+kImK1VwjhqN/SaUaWCSKEGLqRg/nd+PJa?=
 =?us-ascii?Q?OQNiuM/UEe/qToBNPWz1nsamkT77VwkAj0hKPLI+rUR/l8TAO/8AzPC/m7AQ?=
 =?us-ascii?Q?d5suMXjLoR5j8//Jpl1QIIXmYEIry5pBaSFivNdpZ2dXtbUe916I2f71N1uy?=
 =?us-ascii?Q?IkxrxB+CzXfvJ82f14LRS9b9lJ/8IdFRLtQOFbc80qKj8OI8S7ZF/BnohndE?=
 =?us-ascii?Q?lEz5ds8xnjfYwYa2rKkWtiYLBmlXNqPxwPuLohGSxTCe9lZ7ZhhSW9g85+vz?=
 =?us-ascii?Q?146+JP1BudCvi+pLtBYVn0I2GwluvEWpniaAykurRD3pdEVVsAvfDbpP1CKO?=
 =?us-ascii?Q?w9Vji8L4PfJES1rxaREFgGzgxuDnPcN+0cGmiEwU5gMsvcGAbYlQMuAJ94cJ?=
 =?us-ascii?Q?r5zsnR5huoNWBG2AxeKxNpiQbrGdteUeOlvGj0I2mpoHyns3wQ49jHxUwUDd?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e75fa5-f27e-47cb-7fdf-08db047c6c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 17:47:44.5208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUktM5NJwIacu0vfjDwWW0moLOhK81ROegioYyCjYyJzTUoQctxAnqpi9rfqU4izHmNkAQm29omMWMqImPtJgUlkUskDcZ/6jlPFex5I+Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3376
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, January 3=
1, 2023 10:10 AM
>=20
> acpi_sleep_state_supported API is only define for CONFIG_ACPI flag and
> thus it can't be used for non-ACPI builds. Initaly there won't be

s/Initaly/Initially/

> hibernate support for non ACPI builds.

s/hibernate/hibernation/

>=20
> This change will help adding device tree support in subsequent commits.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 52a6f89ccdbd..370ec20d1993 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -234,7 +234,11 @@ EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
>=20
>  bool hv_is_hibernation_supported(void)
>  {
> +#ifdef CONFIG_ACPI
>  	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
> +#else
> +	return false;
> +#endif

Is this patch needed?  If CONFIG_ACPI is not set, then per
arch/x86/Kconfig, CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
is not selected.  In that case, the #ifdef in include/acpi/acpi_bus.h
provides a stub for acpi_sleep_state_supported() that returns "false".
So it seems like the existing code should compile and correctly return
"false" when CONFIG_ACPI is not set.

Michael

>  }
>  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
>=20
> --
> 2.25.1

