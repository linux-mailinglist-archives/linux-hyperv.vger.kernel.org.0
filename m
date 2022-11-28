Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA00863B22F
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Nov 2022 20:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiK1TYI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Nov 2022 14:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiK1TXm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Nov 2022 14:23:42 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11022016.outbound.protection.outlook.com [40.93.200.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880952D1D2
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Nov 2022 11:23:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEsFTRZkryJSijzmQbevQTftjBdXZSIknwzk+x/uxfCJH1mBhdBWIxyMuxvxwcvOFKJ+ZiakL7X7fxQADZmoZVKDndECkUfw5JsdoTC/eWgLuUTp/Kw3ateKN1QfXaYpVK+G4fXWarf/3y3xjVOL7zc/yASM+wAm7mY9JQ7EldFzJK/JZOr04oaBT23MFhqYrjEwV/+jyvqtiEi6Rt5Kkkn5tXC3xsEA/1u1gDnKEHgveMAGeKb8z+1KrHzw89/5Z65EennHz/ZpyOW5FsgltkpPflJpMA2tpF6TMyaaCa2907I1kpw7uDULTOF86GjsXrdHTOgt3/7TZOVMyCB76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AZHJ8yK8F6gF9v2tJtZdwEfaiYt7jtL+ZzaPQUS0pI=;
 b=cXiu5oAVlOY+DUK0SVYIdvQi6jgHt82BbwY9+78zRU3PRhxal7bo37n+eGaAIuqWMQxi+AkEdmtcX2zA4nnyoJ5M/aXnovDu+febl2jnhBhz9WP2vZJqBx4as7mc8EArk83d0YTep31J5CurdMzeMD6tTVLIH3woHSjuAzUSeyCdyn8x7mi+aAHakuedGqcgYypDC5X5WoH6yyYmEHRNvAf3fpXD6NobHWzXHtnVe+GHvK3shaXw9EwVE4LHn7YBrnPblTW8Y5SMq1bllh7Kdy6o5pzCtrrf3KzbWRWqHKoTKRYbR+g+pIJiqapkPhdtmX88/tgIRclbgrMsqDqfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AZHJ8yK8F6gF9v2tJtZdwEfaiYt7jtL+ZzaPQUS0pI=;
 b=PLT+LX6qz/o6ORXJQ+4POm+7Iofmt9Nu5KDRL3gcyx1pRPwPk2oykgX1AiX/nD92MNZkiQjgzXex1IcvtF06sIumZksYJcGJ0j/9wV/QFT+WosEAufAmajQg/uBBbv9Yoq9+sqfuoXpuEki5K2sjLqt2xZVYPfL3iCJzj4xD0K0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB3845.namprd21.prod.outlook.com (2603:10b6:303:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5901.4; Mon, 28 Nov
 2022 19:23:33 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%6]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 19:23:32 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Gaurav Kohli <gauravkohli@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: RE: [PATCH v2] x86/hyperv: Remove unregister syscore call from
 Hyper-V cleanup
Thread-Topic: [PATCH v2] x86/hyperv: Remove unregister syscore call from
 Hyper-V cleanup
Thread-Index: AQHZAV5sgeEyTyQYJU+vTR79Iuzjm65UusZw
Date:   Mon, 28 Nov 2022 19:23:32 +0000
Message-ID: <BYAPR21MB168846312294BFCD2437B4D6D7139@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1669443291-2575-1-git-send-email-gauravkohli@linux.microsoft.com>
In-Reply-To: <1669443291-2575-1-git-send-email-gauravkohli@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=53508638-d1fb-4dfa-9643-7ce8db061c34;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-28T19:22:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB3845:EE_
x-ms-office365-filtering-correlation-id: 97b27ea9-18fc-4013-8996-08dad1760986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JLb7huLobA1IKmoU1OyzG7SyItADkIvk3hpowPn6AQ1sngzG4CfsEyQSFGJ4Emy+X7yY/T1Ph2TD6p8oMn/dLJjv2PY4Hl1uSepjuhX8HO3cy9y600iSixmZpyI6AKXUMggZjNBAR0KT9SikqX+hzFo+kP+lbkXY4h4Wy0xAYggmxObuB3AGR/XSLD0h6+sBjqrRItiEuZTO5vRX4hFuXuhlAgFh/Kf3C6/0MsNYocrIlMx/qsxxPmB4S8YGmwomx1dG/DIEUHudpHaDDxlPI7CDlNnlhSyn9wp5Q19z0+61VsVWY+DqcWyHy1Ner65PJIX/6s1RAfimaqG54UQed9xxFL+u5Ab8tRlOHk6OvR9M9SmYhF9vYYsBksIAfzOKBpCMIiequC/Qmw+bwVMImBTzjuadchy05z/xgpZygeoYy1EL5sS1etc6ix1tbSW4kKRR3oh7r+ZjOo+g0uGpZ6xw7ZbKnawj9CKdeKQPMNztaZfObQiOxpiHB1H0UwebNAV7LvHlA/6P5t3UGipbWMAxRPmOVTHyT+DchmWfGN8pzcTJcaQfS41OWrgygGLaucpVRlvh2ghGXbzGrdxS7eBpxhCX87U7KjEgixQidPWjmE9mzlUhwqtJIKdn8LVLXp9kdry2zOALwMxi/Gjvqrek3Z0yrTxnaFfQW2xvwa1JBxJnI80lpYenAGaBZTeYXkChnzoQp1VyN4DUSKvy7a8S+BbAN7+S1jcq6R+hqxUcgvDsjO6vYE3K+bVwRFBKiKEEsVLzEYxKU7bG3MlZ/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(8990500004)(41300700001)(8936002)(5660300002)(2906002)(83380400001)(52536014)(186003)(86362001)(33656002)(55016003)(38100700002)(122000001)(921005)(38070700005)(82960400001)(82950400001)(26005)(9686003)(71200400001)(110136005)(7696005)(6506007)(10290500003)(316002)(478600001)(66946007)(76116006)(64756008)(8676002)(66556008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DWPhe3s6qI2X/GWff82paBl9o0mtLDOAHEfnQTISsWahvaQs7uQ8yiHZR5cy?=
 =?us-ascii?Q?r6xCCuyRIu7Iqn3UqM89stz/2V1quajJ5lhOSEMPbKzP/g0fIjmHo/KC3nev?=
 =?us-ascii?Q?5Kdpc3GP5qEAaIh0CI5aXYw4AHeUVPdELFQ4nnBCMtBlE5cAEbJynkiMqH51?=
 =?us-ascii?Q?vQnXHzHDZZpRmzZpLxgzl58oSVmWw0W2cP3YddLqjalygB4MxJ8h28aWGVX6?=
 =?us-ascii?Q?wGPj70Ew7oBXld260zD2583TVrxm7XN+2azWvemTI1MtjfbbBrtH7qAkcZEo?=
 =?us-ascii?Q?MO2YtsdKNVamPaMnvW5y6tQ9ll5uuP/35A+7taMUJYnDP95qqSYtKtfR8cm+?=
 =?us-ascii?Q?iDuPjB1oNqmtJWjLpsZdDpmahT71+FGHSVwNe4VwsK/U4BQ2PW7YauM5ebFD?=
 =?us-ascii?Q?k9lHmuT5yHXmPGR9SAz64JsRn1XyLBE+dsAkMeHtZKzX1Jc+HncHY3wZFQhl?=
 =?us-ascii?Q?w2GOUSIc1Top+HHrRw5nSKlFWLsutA5896qXmpnF7zmfRmnj42tOk22VL/zn?=
 =?us-ascii?Q?yVIiClGyfGm4NI3aAOQdNhV5LoC9zDJcw0N79WgRObcg+yrb4wqdd/e9b4qb?=
 =?us-ascii?Q?NQl8lTY8zv73efroqaNRT5B7n1/0PD9eFRlcwJ7epaDnBbQUZRqVW/vUOCda?=
 =?us-ascii?Q?UaZT8oMrawir6WUNVCvQiGsM8f/2dxeeOJHzTYm6l+yQ2xJWPyf2IgAwVSHU?=
 =?us-ascii?Q?Q3pEBZJ6US/tsXP933Qtsj6V6Mm0xeD0kJYBSBxetygGCsXRro/0/MKrRMAo?=
 =?us-ascii?Q?H3kX+/+HDss/cpOXaVaqruDOR0tge9I6WUGM37Wv8yHMNqrvPXhWCzFlL8nI?=
 =?us-ascii?Q?g7zm7CN/hLZ+o8Elyyk1SKAsKkvp/5iVn+T73FC3Ve1YHvLIzzaCJ7mOLtyW?=
 =?us-ascii?Q?ipGt5qJZGeioAiRO1Np19f4SRDJb85Nuo8KvqiPz3OTNUss4zVajgcPdj0o3?=
 =?us-ascii?Q?GBrrienJCswfxX8KsUKG0xwY2kHOIfdngZGgTmowGdQXZl/UFYzF1nIPzM/J?=
 =?us-ascii?Q?rLse7XvFWt/lFA2GbfaGBcVDh1R7qCJ2DhMWtQQnSWfI4DBv7yI9Vcsd+B2T?=
 =?us-ascii?Q?lMizbnAxxhWkLegNoH0qYbgh4DcB58WBDeNKtii2C+flgvyePShc3CiOQSgA?=
 =?us-ascii?Q?MqetjmeX+gjA6iA1WVV3FZIxJTxYPPaVYH/6webmT4e9oaG8dBYlQSFET7Ns?=
 =?us-ascii?Q?yPySZCes5bhAa7X7BnvS8XXgWEaeC77XDdRjtMdOwzK1mSa/NWUz+EIuEOF1?=
 =?us-ascii?Q?xFRg3CG939tChdCSEBzjal8SwuW/3hEisWyPb55GGnp09mpI3xMXYrDpxBih?=
 =?us-ascii?Q?n1iJK6tfZ6DrYlIZsy29c02ISBt189D+ZA8FdnHpzLRfB4V69KAPX1FXkgxO?=
 =?us-ascii?Q?yyoA6c/zNoqqI8dnNzP57FkuW1jjEgyw5l6JsMBkQzxC3tCt5UW8EwJ5SEbh?=
 =?us-ascii?Q?U3VWqgpmZ1u6cvEU1UFZOfDJFGTx02uXWyFaehPagT0WH85YwmzNpcTQPlij?=
 =?us-ascii?Q?5pNoppP2Wo5lYsHRfI4/2xJEhKLsnj0AWr2s4NKi+BP0Rm9EKiE8iPDln2Yv?=
 =?us-ascii?Q?92Jg6OFVjUIn4dPrXZNhr0bmQ3oyK5rhlb3xDaCOH3jb49GFtMgy/BSS8kQ/?=
 =?us-ascii?Q?JA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b27ea9-18fc-4013-8996-08dad1760986
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 19:23:32.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNyPHuU1gVB5gPKaYWzhK2SMFnoHafGBJxC+F0B1HcTgO56RHELsBmqjmd57RikubGVmDfuX8+LUX5u2JLVoEn9UMtheZHvCnFT+LuANcmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB3845
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Gaurav Kohli <gauravkohli@linux.microsoft.com> Sent: Friday, November=
 25, 2022 10:15 PM
>=20
> Hyper-V cleanup code comes under panic path where preemption and irq
> is already disabled. So calling of unregister_syscore_ops might schedule
> out the thread even for the case where mutex lock is free.
> hyperv_cleanup
> 	unregister_syscore_ops
> 			mutex_lock(&syscore_ops_lock)
> 				might_sleep
> Here might_sleep might schedule out this thread, where voluntary preempti=
on
> config is on and this thread will never comes back. And also this was add=
ed
> earlier to maintain the symmetry which is not required as this can comes
> during crash shutdown path only.
>=20
> To prevent the same, removing unregister_syscore_ops function call.
>=20
> Signed-off-by: Gaurav Kohli <gauravkohli@linux.microsoft.com>
> ---
> v2: Update commit message
> ---
>  arch/x86/hyperv/hv_init.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index f49bc3ec76e6..5ec7badab600 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -537,8 +537,6 @@ void hyperv_cleanup(void)
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
>  	union hv_reference_tsc_msr tsc_msr;
>=20
> -	unregister_syscore_ops(&hv_syscore_ops);
> -
>  	/* Reset our OS id */
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
>  	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
> --
> 2.17.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

