Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA5B6B6D89
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Mar 2023 03:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCMCeB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 12 Mar 2023 22:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCMCeA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 12 Mar 2023 22:34:00 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399393527D;
        Sun, 12 Mar 2023 19:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VabR/lND9YaYvaUvFh3ZKU9v2RV1dhAXGp9H5uOEoAIannqIEjX+GMhJUdZ+DaKQsLK22V/EpgNcQCMDsFoj8PeytF8NLPLgOennigohLsTVYUa0TQt7ZiFfjuuVjztoPCdf8nlhvVDrh6gYjQHr6WpPueN/Q6DCZ+KIJXv3RZeHJ/8lry2Pw51wLcaQEfYUCb7K/oTQZ+0kN9KSXb1DHuPxd2AOvIwzgf4q2jIQ/yyeHx+Xu0cPoIZo6YLGP3G19IAM/StmWu9W3GaD2wn1REcdq6xd4YbF8Bg+RmF/BnH1lrkxhiCfRiA6Llvg0F7I5gUuz1i6cd50pYy4UOSrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lWCMDP8lHM1REORbb/iKIxgEbVC5RfmWrlXOsfugcc=;
 b=nsZkJfJw0PgPPLynM3P71ZOhNCd0XfvmUZCXsNYbv6xQOUudEpFbsT5lryxyR3uvCmOlX2dZomEqGMfxMxnAoPtfXGp8nChQNiq+RDXTRddiQnQiVBd6f9RZxCUl7PFqLeGLzm6zB9gvbng1mMvXCVocSLVjc4GbTqlGPkZpneVq2YQ5LGZLnfgevUjVk05EQ2/uA/ySNDWLVyAo410whLJXuzNv2sEBS4nLitl/6v1/WstY70Kr2fGV+ud34NoyYN/OFEKx0wlWWip/AedvuL5f9Uhj9IRYait5AvlFOsLiOdV5jtySSrYeBZrZfWucFFqwhIQPtTRp7UcbOKvfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lWCMDP8lHM1REORbb/iKIxgEbVC5RfmWrlXOsfugcc=;
 b=T7hVvAcbKJpxmQxL3JXYZ6Zqt+B7fn7IHTekBQ/cavsJgaTj+Xs+ksyRnKfdiuah/aE78ATyaKgNCZlu4k1diMCO8GXnLY/ZUbdMlT4MbBTf0SSgZuTEgXZKIJKn5esHjjPQ06tYmeJ5EQFB9qoKPvMV+AY/dIACIEamBkM6FLk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3139.namprd21.prod.outlook.com (2603:10b6:208:397::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Mon, 13 Mar
 2023 02:33:54 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 02:33:54 +0000
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v7 5/5] Driver: VMBus: Add Devicetree support
Thread-Topic: [PATCH v7 5/5] Driver: VMBus: Add Devicetree support
Thread-Index: AQHZR3oO8XCRAJVOTEyd9eleCYLxd674F9KA
Date:   Mon, 13 Mar 2023 02:33:53 +0000
Message-ID: <BYAPR21MB1688B84E25DD2173B6023737D7B99@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
 <1677151745-16521-6-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1677151745-16521-6-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ebc9bea5-6be5-4816-b84f-bd37f41a9749;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-13T02:27:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3139:EE_
x-ms-office365-filtering-correlation-id: 9d03ad5e-766a-4a61-1c7b-08db236b636c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vxytz2VgDtOO2ajHuvfNJimRkBRg0TvwGf7r1RYa8ztPANq46oF+QF12FdIOMrsmkiI6qL9AOSQ7plyK9mq53aVT6n7cZeQVaTkECGg4Vn4NiQMvesHHFhxPmqm1Ieu65mCk/ZX6p4aZ86w4LvfMV/RRGCNNXI+d3fbw0eXiPLs2EhIlLnAZWCmcaDkISW4sf7LhpEsCAai1YsetrhEoN2Y3oKy7VyavDBNRD0R5+JOAia25oyRRZDs7DToddbwC0KLQKz93FVad2sLzidtmhmp4tTknDwpQrjGKzbKOCtgzbyeibYX0IDMrxUEONjGeuN/bv4E/KYr9j04hzZLXd2JlVvkXvz+SrFGvsVVI/5eUDqcnSDA0blXf0xePUeWdPgBqfS+wvYV0hjXXk6uufHjDk7Lb/yFTIBY5E2892ZftcTLP0e625JJ4gEv3YTF7kWyhmSrpEY6kTxQFR08qpcwpThFw/uRurxu5Li4mf8eNregrglcmAQ/ipYPgE6FM+SZRLg0UwBBLrwXMGKFp4ITtoZJhZDchFXzl3m00XUE1/z9gTSCzIZQkGib+FYT5/jg7IEw4/RG8W9hVx59YzKqNFxM02uCFlTuijCT8BbLqKBwZ0SUs1h88zBcHzF1zj698eJEskpPoWnRO7UUB4uN6bMdFsSbD4vk7Ji4VZwRiPsP1jRJIPM+fdxmsCId1LhtQIoHizegXlmdKn7YKODGL6INycW0DieXPr+j9pfMkAwXJ9J9jMOGNqqZqN3R74FUW2d5/p3T5b+TG2XMTkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199018)(8936002)(7416002)(5660300002)(41300700001)(52536014)(55016003)(921005)(33656002)(86362001)(38070700005)(122000001)(38100700002)(82960400001)(82950400001)(2906002)(8990500004)(83380400001)(10290500003)(478600001)(71200400001)(186003)(7696005)(9686003)(26005)(6506007)(110136005)(76116006)(316002)(66946007)(66556008)(8676002)(66446008)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d4916ZGtdaDDYRjj/jPpfv/1dOkMYp1KwDB3rheeHPMmBB8BNLW1nnGnOvFR?=
 =?us-ascii?Q?GvFqTuqex68L88HzVFM8AW7lFv1Z79qiKTupdDwxEVP+UEign3s5PJA667Up?=
 =?us-ascii?Q?NhFSD76AOX5j8U89T+Lh+8QNwxURXWz4WPHVQHkF30jqjCcm4EGHuJZAQnoD?=
 =?us-ascii?Q?2Ycjug6Jg1jErpayXca2QsfAcwtRIEJje4ywEO4nLxHv2NlEBVaOS4GXb70L?=
 =?us-ascii?Q?dDWYaOnnvMxuyLLMqhQkp6L4JSSK974qabUwZ62aMgCEdiNuEmhzxIgPlBXV?=
 =?us-ascii?Q?ROiqOx1KHtEDVpsm+wYOMR3L9E99qi/MO3RKEYKWiTYJi0QGQnmAeJWlO9Ed?=
 =?us-ascii?Q?hVvHb6KP0YggLD8x0dfs+MoHe2809b/JUid37Q2P9i5GUl6pttKOrKM4/zfy?=
 =?us-ascii?Q?ga7MKIfSmkodc9QyqD2y6gj9AovDDtxyWfAHEcPL7nolIqFZqwAkxpa67laQ?=
 =?us-ascii?Q?4XH30Y2fNodZ4TdfRmbkdt9NIPY763WEZ2AKdwuBKDa3qrqlRb1anZqxDiGo?=
 =?us-ascii?Q?7/PsjmM7EBXaR4ZAa0TW3WGTGxzkx8LcxAc2ntAz1wj9Ix898/2rOQGybf7e?=
 =?us-ascii?Q?/9DG91Hf58+wv1tbIOxS1mZ06zgnRBgqhpPZhvESqGJcjxB922tA1mGX9tuC?=
 =?us-ascii?Q?Sk7IzK0gUZdqCLMotGIh1ZT8FpPBjcN5huflmk6pHFb5RgcWvArEuNi13IoF?=
 =?us-ascii?Q?rwmU5CQcMO39/gwk92Pu9YMoAo9VerzaKMVKNINYknm9N9MbVfGXImMwmp4j?=
 =?us-ascii?Q?huUcQa+NluJTRdqui0mbD95In7u5P2D+lLNYE8A9DjfRM+4u0fTQj7rQ2miI?=
 =?us-ascii?Q?RCrLumnCz1/2kETUIp6hsUxIxQqvIkhTMThNXwY9MRE3MSFPo1B5lciX1wOb?=
 =?us-ascii?Q?XGmGYfXMph+GOGUuiviRMekSLPdaJQV0mNPsxYCm7FFv9QtN2m/JbI1hJCW4?=
 =?us-ascii?Q?9J1AqpBp9cCDC46dn5v3NYAuH5g0s66xh9YLDYdw6tN88kjnfXmsADkDPThZ?=
 =?us-ascii?Q?x4xBEmzkIXMNm9lmOnrSYwOFVM0F0ypr/dIR+x5yDVDGOxtVLwLIZimCbO4j?=
 =?us-ascii?Q?sS4O7xqee9bbt8uMk/jkaho2aOqBZpskhu6MxBHp2fwLM6IOfb5zSHowQeFV?=
 =?us-ascii?Q?uiqSITmS9+qfxW33gastO/nV1Zx48GzNClFC4XRmuG+ClFc9iLghKouOdCwY?=
 =?us-ascii?Q?MFsPzIyofwegrGcGo7eTu1cSEzxZaaCSklmvT0iEOZCiQOIvoWbw8BlnedM6?=
 =?us-ascii?Q?V4OMYcdrGMqXsJseMP3kv54QzPux4y4pUHo8CVxp4YygmautD1/mYAvr4FGA?=
 =?us-ascii?Q?DDClmodFYTTuHi5uAenzhOkupHb1KkzKt5b9CZS1Vn1Xu5f0GMtaXBn0NvuI?=
 =?us-ascii?Q?dToy/Y4ASxGfMLHoZmiCq9CGjya+XEvcU6Q9OYZEMCI8hLYuLdpLKqpna3Y2?=
 =?us-ascii?Q?qWlJKwVmRThrwZ4dV8qkOF0S4yyrZ6Zw/LhO7VIz2jOOq8WTddfRjWuB7+67?=
 =?us-ascii?Q?HpKQJUspSInKY+xQYWDDislR6VyGIIzLWy4LPP5aMoUA3mj3ePo48V5JSE3H?=
 =?us-ascii?Q?qgwQsx02iX1g1CwP0lHoCpopDgpSH0hnvRUj1ZJycPuAUuTeWQ9CxQbQTje3?=
 =?us-ascii?Q?ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d03ad5e-766a-4a61-1c7b-08db236b636c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 02:33:53.9403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxJM2xPLa2L/fkmYrzZphvadSjFRaWXpOzw30P9VzsXLyOf4wdXz7CBgXuBDKElcE5W0owqyLe+LPAtpCMpz8wCCYjrDWUegT0HhQzmRTgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, February=
 23, 2023 3:29 AM
>=20
> Update the driver to support Devicetree boot as well along with ACPI.
> At present the Devicetree parsing only provides the mmio region info
> and is not the exact copy of ACPI parsing. This is sufficient to cater
> all the current Devicetree usecases for VMBus.
>=20
> Currently Devicetree is supported only for x86 systems.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V7]
> - Use cpu_addr instead of bus_addr
>=20
>  drivers/hv/Kconfig     |  6 +++--
>  drivers/hv/vmbus_drv.c | 57 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 59 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 0747a8f1fcee..1a55bf32d195 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -4,11 +4,13 @@ menu "Microsoft Hyper-V guest support"
>=20
>  config HYPERV
>  	tristate "Microsoft Hyper-V client drivers"
> -	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> -		|| (ARM64 && !CPU_BIG_ENDIAN))
> +	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> +		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR if X86
>  	select VMAP_PFN
> +	select OF if !ACPI
> +	select OF_EARLY_FLATTREE if !ACPI
>  	help
>  	  Select this option to run Linux as a Hyper-V client operating
>  	  system.

One further thing occurred to me.  OF_EARLY_FLATTREE really depends
on OF instead of ACPI.   The ACPI dependency is indirect through OF.  So
I'd suggest doing

	select OF_EARLY_FLATTRE if OF

to express the direct dependency.

Separately, I wonder if the "select OF if !ACPI" is even needed.  It doesn'=
t
hurt anything to leave it, but it seems like any config that doesn't
independently select either ACPI or OF is broken for reasons unrelated
to Hyper-V.   I'm OK with leaving the select of OF if you want, so I'm
more just wondering than asserting it should be removed.   I didn't
see "select OF if !ACPI" anywhere else in the Kconfig files, and it
seems like Hyper-V would not be the only environment where this
is the expectation.

Michael
