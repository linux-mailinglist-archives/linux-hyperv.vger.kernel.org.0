Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63E9542649
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jun 2022 08:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiFHDDC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jun 2022 23:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240954AbiFHC7x (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jun 2022 22:59:53 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B251E5635;
        Tue,  7 Jun 2022 13:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkg+uTsEFD1oNpbOY/5FopIhr/mFt0ky7LBVY7TlVRBg6GEa+kPdMPpDseTuHc1+j+FmpIAfCiX31TWLS5V+MpjiySVogrPx9shg60FYHuIJPTtu9Va6fMKX+LXEV9B1ghg0H8nFcDF+3bUuDctIJvMXU8bPX17GOBOG03/fCWlHck9O91n3C2YTpx+Cm8rjfHOqFGTt8VUuCQ07yzQnGzCyfm7u5WOWK2Laa2zx3Zgyuip4LHLqlfuAYYoQUqWTFHye3GYbeiBV54fhfdOpJdvB2oqsWsFOBD2WMiRHgE2wowz3TXCYhNL7TnRWjcRDar+EpeFhw+r8GW5otLFqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFJD4nGE13aoMnULt/F6n7WZo1lv02wXT+rL2gsatHc=;
 b=DQ7EVZNdW6/SKxQMQbpC/jo4hQatyKTFFObEogqbvFtkXmDB5GNlX02VJs5qnHJi/3z3VDIATJ3tjP0TxVEv3+gigJWMZvWeEcwT5Hp4rVcHMXIIrjzUBeu+dSti1mejW2Zl91OLDePZ7xh5KkIZ0JdS4BaV4vtrKHEzo1c71CRfu9i3ZsN3xRAU+yTv9vMtvbp04b84qot/1MkCJQcZlwKJAITvEBD4y7l1xiSfSZwxEzJxthoXWsNF8x+kZ6s4WmuxdJwJDSEjqd0QBGy8EQzAxfvJyrWpzTFOluUcr8rgnDnzP8Q3c55PPIuk0Rr7EF6PwkRWVWFxn3yAWU8Xgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFJD4nGE13aoMnULt/F6n7WZo1lv02wXT+rL2gsatHc=;
 b=QjCWtpt8W95icWsnV8pkB/hX0uFO4CZTgkVSlhxvjYKKEld9TkRBGCPYSZRkrgfAw/Jq8Tj3XyRCHRT24XiveK5UcyeMCHT9P6iTiyHP7S7vS24/iXUcQxy4wz5afrsVmb1gW5DFRjcLMd+5q6ZXILDgN3XIfRPQlDAyMp4YeT0=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by BY5PR21MB1505.namprd21.prod.outlook.com (2603:10b6:a03:21f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.1; Tue, 7 Jun
 2022 20:35:26 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013%9]) with mapi id 15.20.5332.007; Tue, 7 Jun 2022
 20:35:26 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clocksource: hyper-v: unexport __init-annotated
 hv_init_clocksource()
Thread-Topic: [PATCH] clocksource: hyper-v: unexport __init-annotated
 hv_init_clocksource()
Thread-Index: AQHYeWLGpsX0YHE0+0W6UFLVG0zbfq1EaT2g
Date:   Tue, 7 Jun 2022 20:35:26 +0000
Message-ID: <PH0PR21MB30257E4B6F2173ABD141DED8D7A59@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220606050238.4162200-1-masahiroy@kernel.org>
In-Reply-To: <20220606050238.4162200-1-masahiroy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=825ab87b-f4bd-4961-92d2-e0281412ffd2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-07T20:34:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32f63133-cc5b-4a52-cd3f-08da48c5413e
x-ms-traffictypediagnostic: BY5PR21MB1505:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BY5PR21MB1505741D701DAD7A95636EE6D7A59@BY5PR21MB1505.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: THBFurDpI9DDmtMf+GUTFF0kiu584XeubfG0UC5ghZ+uOdFaMqOk+vSfpnQU2/Z9FfW09CaKOGt4F8g65CR8hIDbC6HbWRL8fzbkUSlGJdIL/Y9FoMzd+VRsaXfJnW/cc+6VSD9iIl/aRTyficmw/qymT3/DENwMgyxqdM4UacLW/v3eC6zpAruxDjcQK4aKSqJIx/QLjGXC2n23ctB4zY4a0AwNAe96lUxbS0JvxQpj8e5pQdlCXsRs7agJM+Xv2IxNvfnQLIEkhYD7ZQLgl0troOOj6ZgmKUAYCGrxDrdw2j7pfpIlvwkyA3Oz0xH90YpuAz0dw8qcsIs7Tn0Zt6/kSLXI4YT1T4xLWMH4Ju+IcPwGozrPNrEoVwQ69tZW/WD1iBpXqb4s5YCGh+0hpzjSQFUYgxLdIMPM/i/8uXhNbmN23ZKo5CdQLij9zCCK3omVXPgXndaQeV7wBMXPoOwvfYch6fUiBdWxh+Qatjns7O5UJ83HXxNlyPf5FuR6xb2QFyko4JqJ1f7F8wvPHV9dK+0y9UW/60Px6No2dQ02IbP0hkU8aERQHVKXr0bdLBv9PDBLWCPpHm3HeRq7NCMSeD0M86ws8r3ZCgDsTLMdLrrxyu21rMj+aOdy8tjL2QUN6Kwvhp3NOmNYNZSRMi3Swd6LDlhoTbWZLII2l1LzvJ6nbA4zBMNWfx/N6k3UDoakMQv1RNf+9ye01X6n8HKDTBWdxdp0QzhucIw+qMnrTD7+IaGIwt9X+jWbuy6v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(10290500003)(83380400001)(110136005)(8936002)(186003)(508600001)(82960400001)(82950400001)(9686003)(54906003)(316002)(86362001)(71200400001)(33656002)(2906002)(26005)(7696005)(6506007)(8990500004)(66446008)(64756008)(8676002)(66476007)(66556008)(66946007)(38100700002)(5660300002)(55016003)(52536014)(38070700005)(122000001)(76116006)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/0vq/EnqNWdKD955u9WWrJI/Q7bXJCi+qTLvKyBTpYOPSBJ3/3EPsRkLml2l?=
 =?us-ascii?Q?rmb2b2r5Q58fwdaN20v7ePnVxTexFP99AUmRURzin8eow9G1+13/VtZCv/6Q?=
 =?us-ascii?Q?SVhAX+ppBxNbnWb9LlEbsQJQVZKx0PRWYbKKLy0cjnP2l5QqAMoAf9Xhwefb?=
 =?us-ascii?Q?6xMqeIKe45fjC4uK9Y+BZWv6h5ZL1xBpLGIHxEYN1uA5/Z6T0X+8upfIbeJj?=
 =?us-ascii?Q?DWa/6kR1PQoNvzpqkT2PfVAPn0PPBCsdH0GpS5Uv2gBcFUvOG259Oxmvbwk1?=
 =?us-ascii?Q?mFu9q7k7tl6qaM8bHne8nLR1TETZABB+caUNM6jEpxLXvGXNYJP2yZbdBN+m?=
 =?us-ascii?Q?kdteWLBzGeUSA5TxpFwPL3GYkKKaah0G2QatwPN+wXiyR5mw26rP8I57dIVl?=
 =?us-ascii?Q?l2PtR20vBGB8EAaWAfCSvgAhEZVnyvkbDIKhOcT0nDfQvHrcpOIMgxTI6mHz?=
 =?us-ascii?Q?KPYLvYKdjnFUnUhQgBm9OoZ703KQShV08GZG3Nby9t+51ZF5+WKjYnjzNh3s?=
 =?us-ascii?Q?BGMrZOu9BWmwIh3YYrwmPu3hwpztinG7ulUTFBK7XFxHPggz2ejxm1Np/Nob?=
 =?us-ascii?Q?CtKUcXsjWDS4eEu18NdNAxjzZQ3hLanXq7yrn/M3k/sK6WGa18BoDZxac6oz?=
 =?us-ascii?Q?lvm2bw6qP5TzyVuAS56OAQEY9gFkOSghqL/6KA+2gOcp4hJOz6ERkU8bcrAW?=
 =?us-ascii?Q?0x6TQ4LCU/4X6lcutaXEPLthi0FGl5NkH6z65cbg0z9fmPTaHvg4cbSfxE2x?=
 =?us-ascii?Q?PuMo9D4/uTGmpuF1aeaWPn+qnyXCKvxbS5MtXctcDQ5vBjKxZgjEcL3EwbNm?=
 =?us-ascii?Q?CWyQ7o47OsKcyULohNz0D4mmDqcz6t+X7fmwFFIGAerZW3cTYgCjCPZZaeYW?=
 =?us-ascii?Q?u3XOmmAGR+AK1ZjsVztMHMfww3jLtZvlBs+Mz2c2Lv+jwGNVP4w8q37cB5T2?=
 =?us-ascii?Q?RmgYlKBbnZXBeNlJAG8uPypxJp3nsNlTy1SywhGIbuLzG8QT7T/14LU8H9WD?=
 =?us-ascii?Q?bo9ATsnVZr2/wjw+voQmrz3bjSqT1oEZSu0LdI5eL+Cy8OfBtWrQsIphriDm?=
 =?us-ascii?Q?AjzXeP/Tt4BNBpdJDPlz2Uo/WdTdIS57V60J83AUL1W08NpwKEDzkN26oR5H?=
 =?us-ascii?Q?BSXjuf0jz1kY4Uxy7rMYJXiwK506AADwcvFT8JMMKPVL6pdpIFVkzEI+A+m5?=
 =?us-ascii?Q?jMm61k2m7ZfRUBt6DSc+3/j++Y5reQatoOFrFu0OA3tnoPksDEtBRkaYRj87?=
 =?us-ascii?Q?KcvnppP91MP2Zxm1FY1b/qrATL+ksaE4zcANUV0bf/y8SmvfW1tkil7w4g5k?=
 =?us-ascii?Q?UtZdEcK4zJFRBHVNtO9Q2wU7ZY29DbE9XzFeFK9oQSCbbNYlBVmDEMrC+ksT?=
 =?us-ascii?Q?AakR1uG/8y31iH7EhV62eVZEn5e5DmBpsuC8+rqc65Up0gpnYflTkXuO7mK1?=
 =?us-ascii?Q?7BAdm3ylTulCs0EZXJtIGd9RCvw8sCFEFIIR3GvnfjQrZuF+b3WUqz1Na+tN?=
 =?us-ascii?Q?pY+OhziWtZSl6o5jK0Yse7jtB8BMIibtQ6e5mwR7caz3os18rk52sphBguku?=
 =?us-ascii?Q?tTrMywwE+uhkpg5mZKbP/VnAtEokNhK8wXAV9z13wy7xhwSQmF9HAjPxUX4e?=
 =?us-ascii?Q?i+TN3+bv17+7d/SPzBJNu9ptNZQdJCYBkNzyUM/luu4C4riKSN0xFXQ0hK9L?=
 =?us-ascii?Q?gbcnrKnj62XYuaw/RywNnvFEIWkmXa1aFTzNwJMdmQSYy/MT6jmZQUfB+cX6?=
 =?us-ascii?Q?uzfpiIxfN3rQu6Yx42WUr7ADLAjtJcE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f63133-cc5b-4a52-cd3f-08da48c5413e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 20:35:26.6113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmPc4Hzl3mNtyOm4lu5X26S7QghWsHvG6hskTxejR9yHc3qmH5VEiFkctf9lZagCxT8W/qC41QFU09R05EiQDrOqW8py8PBK65E6piDvB0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1505
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org> Sent: Sunday, June 5, 2022 10:=
03 PM
>=20
> EXPORT_SYMBOL and __init is a bad combination because the .init.text
> section is freed up after the initialization. Hence, modules cannot
> use symbols annotated __init. The access to a freed symbol may end up
> with kernel panic.
>=20
> modpost used to detect it, but it has been broken for a decade.
>=20
> Recently, I fixed modpost so it started to warn it again, then this
> showed up in linux-next builds.
>=20
> There are two ways to fix it:
>=20
>   - Remove __init
>   - Remove EXPORT_SYMBOL
>=20
> I chose the latter for this case because the only in-tree call-site,
> arch/x86/kernel/cpu/mshyperv.c is never compiled as modular.
> (CONFIG_HYPERVISOR_GUEST is boolean)
>=20
> Fixes: dd2cb348613b ("clocksource/drivers: Continue making Hyper-V clocks=
ource ISA
> agnostic")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  drivers/clocksource/hyperv_timer.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index ff188ab68496..bb47610bbd1c 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -565,4 +565,3 @@ void __init hv_init_clocksource(void)
>  	hv_sched_clock_offset =3D hv_read_reference_counter();
>  	hv_setup_sched_clock(read_hv_sched_clock_msr);
>  }
> -EXPORT_SYMBOL_GPL(hv_init_clocksource);
> --
> 2.32.0

I agree this is the right solution.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

