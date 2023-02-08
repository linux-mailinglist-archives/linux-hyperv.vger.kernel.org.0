Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58E868E581
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Feb 2023 02:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBHBfM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 20:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHBfL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 20:35:11 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16F218B2C;
        Tue,  7 Feb 2023 17:35:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFpO5gDjqw0SAXYHbdWraNJjEMHVjMO5d1grY9OefKrzVirdq1+ixjbabDkarQm4L86D74lgSzaze0Br2YyJeRnW8ygVhfnUNogNLqwownyxEUtPNqI+rswAOECTlSJb7yKnLajd0BK5/Cvyyv3p1JcLIF4T8W5YzA1lmUl7nb8n5hG9IMIyQli2ZGklZIdVcBVGXYIrZuB9NSFKY2246bnu6hdLbi+WId9OwtQxV9UrRHN+QqOvvBaZY0Pb1y/oPFwKHBY7opEDLJBVvBKcciSd1NlPkQtb73m/LPCcZJs40K59x+VV7DSFT4+c+8ovEu1BGO9pArGdw4RBndV1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7HHRTtD1hq5N9F7WGNbg5se33lzzSQnheanrUmZ/3A=;
 b=FU2zyv9KNUt788hIeeQOzdGmdggSmjgGooprEtF/C8oTZ5POkJWF+IjH+61afg1EAxTLoYxBIBSpUa6dHPTSGYoYx2U21iDxkPDR2rU0USshiZg8oj3/I+OlkP3HfsQLe/23NI6+MxQIGgCCoEFq7GgWMYlwdsN7fsK6o57q2q5TMMWAkOSvGDgfTYie7ij4nEIXK9aTfBau8jHwsUWFkVaX2UIhsj7+opuiQsL03uOs3nfbtcak5I7YcrG/pe127FUHVMqjyYtzgOV5n+41y8CocBUkhMNFVbNKbFYgNY3zJfLhrl+QTtTZRanvdTkyo63TKwoRI0q9itgUOG3hOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7HHRTtD1hq5N9F7WGNbg5se33lzzSQnheanrUmZ/3A=;
 b=ASb+Jb0B/Z18IGj9/aUJzz4rAJd6GN4C+Of6QjNaFIV3/yeS/Mgk9hhH0FKN08Qxx8WxWdZiobfXBrl8jhPkmKCxTu5DZbXTDYI702cwTTrfqjry3znM+uoZtoU74yqn1PuAuNmcqA6p+kVUgXenshKvv1/goBMue7X9rllJ9UI=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB2064.namprd21.prod.outlook.com (2603:10b6:510:aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.2; Wed, 8 Feb
 2023 01:35:07 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf%8]) with mapi id 15.20.6111.002; Wed, 8 Feb 2023
 01:35:05 +0000
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
Subject: RE: [PATCH v4 2/6] Drivers: hv: allow non ACPI compilation for
 hv_is_hibernation_supported
Thread-Topic: [PATCH v4 2/6] Drivers: hv: allow non ACPI compilation for
 hv_is_hibernation_supported
Thread-Index: AQHZOsjNtoVhqbK5lEeWSqNKZR+UDa7EQqUQ
Date:   Wed, 8 Feb 2023 01:35:05 +0000
Message-ID: <BYAPR21MB168807092CE34421EA96134DD7D89@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1675756199-5917-1-git-send-email-ssengar@linux.microsoft.com>
 <1675756199-5917-3-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1675756199-5917-3-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1c3e835e-bc91-4411-823d-d0f129d93ad7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-08T01:24:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB2064:EE_
x-ms-office365-filtering-correlation-id: a486cc81-7cea-4795-b578-08db0974b4d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i2317z9EheDtEqvofZ/gbhJFhl7fN+rTnmtih8Dgbhrwfp86cnV7b4ClhdYy0X+dy7IEo5ackRQbezfOULPB3Y8CtXfEBK9iuNAInz+G/BFIZsnRFUG0ogWV+r5rcxin65fbeytPVkfTK9XYvjfmiXVaL5L7nQo6wMEZZ8mMnrrPcxRBdKUU5hxgrr8Q6TfACz0TshIfZG8TQr3rWRTpHbca8UrBZ35pWcJjWv45yIPE0yOQ7esZ18qusNKRpmPHe4oovtqaskgpbHhPlJoWPD5+OA7yIX9kF7mqzpIHv9Cgs70YTmL9xyXKcpI/OyTCipS0eGwZ59cCb5HxiGxdX1bIrAHkEkp4dJsb9vptrqlXmc3aIYmvcBAmPJmCT9Cp3H+4c1jvELpPZQNybB0WMF8KAlpcvyfxoObswGjzrz3Qkcn/12S+ZrmFxI6f6LAhWau2PXGmR+2Xrv/rVqlG9/k4a3HqMv/7UhkB8+e0PmUMAddqpo3Oh0YbcnEdJsumoP2e/2I7gH10owU2lwmP+yqvqkc7Tvuj/V+7AQZcjLRkr/cDA8stlFpVWVlSjVK3JWq5W4tr+eU9sj8afCVnG3k+cOh3jCr+BFHOZ10tft5neB32ev/on/C0kPTC1F4iUjEIgq3EFkweIQXmEDa6R5tPYicZOuJbgzUo1LFW9H4NgNlqxHuQmkoe6Z9tyDf/pV3gv/A9AbgwRcdbaSRVlHsPuDI1lIEmLk3hxJ8g0Mee7+hYzRlCXEwoqShTQrlxCGQBQDlKcTVFTQSavm+Qtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199018)(33656002)(186003)(26005)(86362001)(110136005)(55016003)(7696005)(71200400001)(10290500003)(8676002)(2906002)(5660300002)(66946007)(66556008)(66476007)(66446008)(64756008)(8936002)(76116006)(41300700001)(478600001)(9686003)(6506007)(38100700002)(82960400001)(82950400001)(52536014)(921005)(316002)(122000001)(8990500004)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W1VwAjzcKR4hAM2efM111EjvhaRsKNvgXGPTZu6uLaAnlUzUaNJANPM9udB0?=
 =?us-ascii?Q?q+k5wBA6xhwxtZYwcQ/ru6in7u0aUvDxJY7dj2HUhBHQZCDlklVugZBSL6cI?=
 =?us-ascii?Q?YxGlxeEWt4cF3dbvoSOQr1YMtnsVP2blFyenfcyELLuBcMtRFOgQUgYezjDJ?=
 =?us-ascii?Q?6MS9FvvF39IQWVQoo8UV77aMOi86ehc7Dmm8T8SVdzBb9ek9NqWBcQMplRwm?=
 =?us-ascii?Q?FrVQQnC5RtIiK7lQfaqrPS0L3N08EysB2yYZ9VpWKuW8ep6V2cBPxkNEgPQl?=
 =?us-ascii?Q?cDWdypX4CXAh+CtwtMnLEysM3V0r9ZvZU52NHtmR8Q/aVMzMpAn39Zd1DlDj?=
 =?us-ascii?Q?1dSGWvGClJ1jBFTyYQEkbSp1xUk4eNiVq4tVUwvFTGPURUOJ6l7af3FGMgNM?=
 =?us-ascii?Q?rEDS0Xk40iIlA8asHv1d3ARmaW+6GDBQISTjhBGxhidLUo26jAFX8dKglNSI?=
 =?us-ascii?Q?79+Gksjy9s/G2eerKugqE+3S2dSf7y8OPdZ2OR2c0kbtEdWPnEQw3PkgwGTf?=
 =?us-ascii?Q?06JKZq6D173dZcuRL3lMlptwkEoi8L1LGiy7Q+qwVQ75vKceAqxnli7rWU/W?=
 =?us-ascii?Q?FUcZ33ndekcDvy0OxhmUDWRSCyh3Q1dep7yXhLe/iRQJskt4rsq0lBDoVxcy?=
 =?us-ascii?Q?omnj0TU5SG0hlCvgs8YEDltFe1pYmYJ2gvosrq8MsvhKXm1jmF9CoiilPcDR?=
 =?us-ascii?Q?+003/rBNKqN+csf55B5syskmzQP+lOpw1pgkAft/Oq4nJZARF7ZIGEkAX1QU?=
 =?us-ascii?Q?O0X703LEgg8Vab++oqLz+NkY3tvb9OWxZqUW5KEqDadcF9nRaKOY3i8cm+by?=
 =?us-ascii?Q?AX0odD0BG07tJzFvADtKy+S4Z9/RhfCIAl+UzwqFoeqpW+tjCZRzJ+BaoAVd?=
 =?us-ascii?Q?1Kt0PDq795l3wxrz72HUXdPvf+9H95AFhEYxSfgXg1XvVKa3S6PePqn/96Ht?=
 =?us-ascii?Q?hJ/jJ+z6LV1i1sl6tmdu4jcCUQuBF5fHkP+3UdLxqdHlaDQvPD8DmST7xmJA?=
 =?us-ascii?Q?2P1KyNe3S6Uc83tBd26OcF3uvD8gnP1OxHhvaOkmGRQ0PUaHeCubE2A9n3ey?=
 =?us-ascii?Q?fltX5ZxHFCfkYAqN77a1XfeuUP4a2e0uDOlZZeqa+WvWTpm73NX7WZJyLNbZ?=
 =?us-ascii?Q?Tq96KbmgxwM2+YQ45/d1dXgDLTNC91pvMvV1GLmHmLyYtAMXSyFB5rMvp2kK?=
 =?us-ascii?Q?shcRcDvgMDjdZls8cTcALu9z5WlfAIEX4JA0mFHeeJFot93Vf4zSFF2blTsv?=
 =?us-ascii?Q?hlqiQAbUT4LELift3eAHwZ3msutcwe1IKjqL2cEsjKaniyD+I0ZvUr9zye9d?=
 =?us-ascii?Q?aqYa9BW50Zup2jbCtzqxRnYh/IZzuPR6vCNEoyEkyjTznMsDRZ2mBHmgMfjt?=
 =?us-ascii?Q?gTHuZoSgNxAsQEj3dF8prOROr418NHWlyn7BNhgGvW0aZeI406ZW1h8I3t9u?=
 =?us-ascii?Q?8/tGxxOG+uT1RtnwYx6OtxK6ZlGWr41T0m/dmAZEJarad53Gc+XDpER613Ln?=
 =?us-ascii?Q?GbxBgx/icGHEhbmuU5k0GixDKg37aJwO7IqMHsBuDUqIbFayZXkWOGw4QoUi?=
 =?us-ascii?Q?gNL969zhkdE/iMI/QeM7T0UdOTbma8Y83gGlI+uHl6ndJdwGdfXLw4V7mIzP?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a486cc81-7cea-4795-b578-08db0974b4d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 01:35:05.7243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCWelQC4rZd5r/BBajsbFBcsDQVCirH4ARS+wu7uj4gYwcrhAWBTCRyg+PNeozwjl8oG4NYT9G7nmGcB1+DvW93WntzafR++rIBgKXAqbfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2064
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
> acpi_sleep_state_supported API is only define for CONFIG_ACPI flag and
> thus it can't be used for non-ACPI builds. Initially there won't be
> hibernation support for non ACPI builds.
>=20
> This change will help adding device tree support in subsequent commits.

In keeping with the guideline to avoid references like "this patch" or "thi=
s
change" in commit messages, I'd suggest wording the commit message
something like the following:

acpi_sleep_state_supported() currently is defined only when
CONFIG_ACPI=3Dy.  For future work to enable device tree builds, put this
function under #ifdef CONFIG_ACPI.  Otherwise, return 'false' from
hv_is_hibernation_supported() as Hyper-V guest configs using device
tree don't support hibernation.

With that update,
Reviewed-by: Michael Kelley

I gave a Reviewed-by on Patch 1 of this series, but the same comment
applies about "this change" in that commit message.

Michael

>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 52a6f89..370ec20 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -234,7 +234,11 @@ void hv_setup_dma_ops(struct device *dev, bool coher=
ent)
>=20
>  bool hv_is_hibernation_supported(void)
>  {
> +#ifdef CONFIG_ACPI
>  	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
> +#else
> +	return false;
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
>=20
> --
> 1.8.3.1

