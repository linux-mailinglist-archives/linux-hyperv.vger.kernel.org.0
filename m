Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD6B6B52A1
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Mar 2023 22:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjCJVRQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Mar 2023 16:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCJVRP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Mar 2023 16:17:15 -0500
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020017.outbound.protection.outlook.com [52.101.61.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7829F121B78;
        Fri, 10 Mar 2023 13:17:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgTgQUK9LBx14p0S/VoUM7Trhi0Lk/MumCFrOwskLB5FIhftdgZrtA8vkJgBjftZvfX+8af4LyU+s3dBNzBapRJW0riW4ffjENi8SGHak8Ti3y3YLclJdI22NK781KFgJd3dvsG0tTol22xllt3nM+ry8R0tgdrw8D6Qq2psUgK7adGM5Cq6AKnkRDQJZiR6AECM6Qu2rLzHMsuVU70asXDNGDpkwtkCxvn10YMiV5jUtICguMmTfkzh8jssRb2igsAoC9KoL3LOlefqNsNIuMfdpVhAYeD1JGl4XuXp7kOSLXnuinv8UTCJQCeyVNd9ARIO2bAIgX5kE9nSt5CurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLhZnIQDKVwrkbIan3GFSz8d3vwt1PIxbwk7x+dOyDc=;
 b=HdgTqrj5DgIPaS+NBNjOol2adid5rUiJJyWvVAvXYAdpIXY3bz6PYUWnZG2ysqoeMEgZJY5L3+NaziXTl7zcrHMZRuE8kFx17gU0AK/fdlwC3RmQn6kZeh+o5He/3LSey88ZQgtIaKXVXoRM4/ohXu2BHGm6+gNctoVo7iTgCoJsCkA2X/gxuqW+LB1JmeuSlgeN8iclgQOv7UgO/a9lZpbui5v9Tmn/3sVJ5ou+hhIJ4uSbpmOyokrByvXEv6VzH/VdBqmPxLzCtBATswzEf2RCv1iv2twgDx1x1Tf90A9p0K44fO116Nz+6lrYMUZxSFieVBZgMdUYyO6rtZ4Hhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLhZnIQDKVwrkbIan3GFSz8d3vwt1PIxbwk7x+dOyDc=;
 b=e4u67R5XoNBXPbL+re84IpVTtdqIIMfr8QZU5KjGqEjvsTgMWKSG2iuJpuF9EPbi9BOI3gapnk1cboTYvcE9RGFNY/6jguEa3+S7cqMFiedNl3irlhW82sZiPTUnv+BLBII3EIafsoWhNbu0qaXtqGQayF0o3krWGSjVRlbvKQw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN2PR21MB1519.namprd21.prod.outlook.com (2603:10b6:208:20d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 21:17:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%4]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 21:17:09 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v2] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Thread-Topic: [PATCH v2] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Thread-Index: AQHZU2hjnJn1KDSyxUy64FYlyEIrhK70go0A
Date:   Fri, 10 Mar 2023 21:17:08 +0000
Message-ID: <BYAPR21MB16888EBB51D1597F9B9C212FD7BA9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230310152442.cbrjise6uex4ak4x@treble>
 <20230310154452.1169204-1-gpiccoli@igalia.com>
In-Reply-To: <20230310154452.1169204-1-gpiccoli@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c7204e4f-5077-43fd-8cfa-d8aecec0817d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-10T21:10:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN2PR21MB1519:EE_
x-ms-office365-filtering-correlation-id: 5bc0ef8c-7d93-4606-4f7a-08db21accebd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bwmGlVT5fxhoZm8N8cXG0bFRviSwaxrd6s8haMjJGYxtpiQKO2nvOcK8OyUB8iCZb6+EzkN7EVfSXpMgHITiu6oSmfYj5ciSXpRV0irJ2xcRY7qaUAHUsb9vdQhHTbDi+uBercZWmtB1u9dbtRnYFAiL32G1ZO5Z4nQtoiD02Ku4FZVF58QbEQ1VIQ50b/93eRp9AGF4nXdVk31bzJJenw5GOlYIhLpNqG6jpRvWnctGmzZuR/42Q2lS4ivoF/PyetBOwT8BzqM2xVrDEoKw4XhAZHa/Fx6mXHj7JdnO73SHa+yjlybcvzXFaspTo68+rOck8xW13UFf5WXLLhy6PpJoOJyrKNMS/xmm44iGhUnxm174KLLAtnw1z2VuNiSJ1edHM3JGytHOIcs5Lyg+dHIQv3lmsJr4ZAeh4O12LWKxBudqPkb+oiNfE7esEiri9D/H/5JkobO6wyvecDet21nDnvl+EHgVSXbs1GAk+SrcTXjP1oQndWestTz9dSuxMj/OmaYNhr8ZPRLw+9m2nIzWPt8acX124n3BOka9Gca1glv0KrzqcyYeaf5iIddMJB77nr3eDufehDCbkh/iDFd2LH/+s0wz6Uk0h1p76Mnp7wbhVI740QgZyIVCQUNUR4Jka9/ZEZdbTdyHN4a6+HujvfOy20Wrmq4EaOYqZlumJXIZiOZl3s7M5yMswVh+TyzpkGGrhrw8HZKhWNijoyzaOtmFaWD4YVbXhQPgy2w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199018)(7696005)(8676002)(4326008)(8990500004)(83380400001)(38100700002)(316002)(82960400001)(478600001)(82950400001)(54906003)(110136005)(10290500003)(8936002)(52536014)(33656002)(71200400001)(186003)(26005)(55016003)(9686003)(66476007)(7416002)(66946007)(41300700001)(86362001)(66556008)(5660300002)(76116006)(122000001)(66446008)(64756008)(6506007)(38070700005)(2906002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H+Rrk50EDG6W0xK4ASV0qNipAiQ3AvlOl8LbA+UhO1yzXGnfHnzgLl+YaRrA?=
 =?us-ascii?Q?BflkuuwQBvhuAXRaMj0G748vSxVbNNIHzHpCxcpsGIz0tEbEmFxvA9h9KacE?=
 =?us-ascii?Q?gVp7lxiUxXRfImNUKZouJq7pUd38W519IfbubAsUM2XX8RC1FJmlXveEt6QN?=
 =?us-ascii?Q?A/Zmk3gQ++v9Lbklnm/wt1HGpIce50YqbbnFkTUG2DHLySWImJGNrPG3T/oS?=
 =?us-ascii?Q?8O7z++JuUf8vEJrc2BO3iDe71L7SZOwA9+yidMCh2U7hFgc8CKdbrV8W1Jcg?=
 =?us-ascii?Q?5Fg/3NQm6AaGxRwcvIK0fVb1ezl1WFWcCqx494P9qUf4V5MwLyuqtW7U1RPB?=
 =?us-ascii?Q?DFnSGTJdScl4nAkbMCgZEceRX3dekjTkLVibNt2gpvtrxT9UizLbVxtG4jmi?=
 =?us-ascii?Q?1UYk6EkmvJfBHXOj6E9UN7uZBVDN7XbMN1RUQ+HCLgogm2xoMQmQvIB2jCMJ?=
 =?us-ascii?Q?DmdFIWP1C1N0EFYG+58FE1vbhmmQWCKzpjVfeAEh7p6bLbCLmWotTDjd2T6c?=
 =?us-ascii?Q?ZGccPL147dIftxXVQO2p2Mb/NYppSBgKxbPYNM55JIunbwkhaEklrpurnrEg?=
 =?us-ascii?Q?oEIBnhx2+6hYC2Y4s7Bo6T+Oj+CdDfKQQhGQVlswBuBz/6kh8GaCdY1x5Ryb?=
 =?us-ascii?Q?wUikDpp1NQDYLSlxde1fYbVAQ0WB44L9HfVWsEnpVeq17ElRXYmhPyRMBkbl?=
 =?us-ascii?Q?BD/VV3Jpp53u3OV1SyzKrftcQ4AHsFzrwDv5NQNNB7/I4ENQDFYVf9bFVJht?=
 =?us-ascii?Q?MWvGIXkgxzu6IIHhVBRTIAvP7Ni4mwYs9339GxkvPtL3Q+iiPJ1UtYkciWyx?=
 =?us-ascii?Q?FpsCfsLCkpHZWOemmINvcVRC4R+drhCPxYHK5XStlWvOLQWXSRrBqbqjspSe?=
 =?us-ascii?Q?leCbx7qmipS4FyfapiMQzjWpgdSHa9NFxk9TDKqk0RbvYGkLzf4XHPpO9C3H?=
 =?us-ascii?Q?wC1Koir1KuwJ7cI7Am+JHViP+vUj0cpb9lJc2e2X06ll0omS3h8U5e1hhGTY?=
 =?us-ascii?Q?0ngwfUzeqPT/9KArXruGxY8faNGf+7mpoRv9YWnLpTObZDTfRfFDg9zhqBVg?=
 =?us-ascii?Q?y8mXDL4QsiOIgjsyTPrVX8XA/VJB1/d0I47Aj1GqIIn4P4lFQ3KWsnWWNsWx?=
 =?us-ascii?Q?6dvxk4PaaJGH5HP/oQ1YgGCjRPtWWebQB5NsUYYGLjqSBMTrxIKHPIo8kTgx?=
 =?us-ascii?Q?dAGqJ9uCb8HGgCwLm6n3W4L7yor+7GCYZGkOSCpXYm/QVRESwUHjevRRK7+h?=
 =?us-ascii?Q?/anBJp64umhs67CSd7za45OQCTOW+54wSywUy9TRbDtKM3yRWkyNCQUi0j+y?=
 =?us-ascii?Q?ybeRdxDTwzpuRQwRSVD7zCyMcDc4veRH68Ac33CZKZ+00uaeDxtyUTemx6Qe?=
 =?us-ascii?Q?/Yxb4Ryu33i82xqAwHy8wqinjSZSI/SEZ2urwmlR4X7W/Em1LbsntAetvZe0?=
 =?us-ascii?Q?J++MPvgyny+7Qnfoj01WMkN/0jNVGxonyzS/7OnB0BlpetU0ZW7GPt8aWRwu?=
 =?us-ascii?Q?RC4P2SS231t7QgeJv2/rKwTiZ7603M1amyWog2v9eXJTg+Ib/M8k3GglUyT6?=
 =?us-ascii?Q?xKtl7yldj2yWhE66B2A8n1iuwBo5FOr8lXeTnMYi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc0ef8c-7d93-4606-4f7a-08db21accebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 21:17:08.9036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+KLXDvnxEe+BzY6PLmz14GWRo6hjgrp10FHIUCva6gMxXWcRFN6hmUtTYLecPUcnbGQZUq7tLxFIfN2waxMqpu4HJjAHLrJtDks+hgX668=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1519
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Guilherme G. Piccoli <gpiccoli@igalia.com>
>=20
> Annotate the function prototype as noreturn to prevent objtool
> warnings like:

Just curious:  Should the actual function also be updated with
__noreturn?   In similar situations, such as snp_abort(), the
__noreturn attribute is both places.   I don't know what the=20
guidance is on this question.

In any case, thanks for doing this cleanup!

Michael

>=20
>=20
> Also, as per Josh's suggestion, add it to the global_noreturns list.
> As a comparison, an objdump output without the annotation:
>
> vmlinux.o: warning: objtool: hyperv_init+0x55c: unreachable instruction=20
> [...]
> 1b63:  mov    $0x1,%esi
> 1b68:  xor    %edi,%edi
> 1b6a:  callq  ffffffff8102f680 <hv_ghcb_terminate>
> 1b6f:  jmpq   ffffffff82f217ec <hyperv_init+0x9c> # unreachable
> 1b74:  cmpq   $0xffffffffffffffff,-0x702a24(%rip)
> [...]
>=20
> Now, after adding the __noreturn to the function prototype:
>=20
> [...]
> 17df:  callq  ffffffff8102f6d0 <hv_ghcb_negotiate_protocol>
> 17e4:  test   %al,%al
> 17e6:  je     ffffffff82f21bb9 <hyperv_init+0x469>
> [...]  <many insns>
> 1bb9:  mov    $0x1,%esi
> 1bbe:  xor    %edi,%edi
> 1bc0:  callq  ffffffff8102f680 <hv_ghcb_terminate>
> 1bc5:  nopw   %cs:0x0(%rax,%rax,1) # end of function
>=20
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/all/9698eff1-9680-4f0a-94de-590eaa923e94@ap=
p.fastmail.com/
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>=20
>=20
> V2:
> - Per Josh's suggestion (thanks!), added the function to the objtool glob=
al
> table as well.
>=20
>=20
>  arch/x86/include/asm/mshyperv.h | 2 +-
>  tools/objtool/check.c           | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 4c4c0ec3b62e..09c26e658bcc 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -212,7 +212,7 @@ int hv_set_mem_host_visibility(unsigned long addr, in=
t
> numpages, bool visible);
>  void hv_ghcb_msr_write(u64 msr, u64 value);
>  void hv_ghcb_msr_read(u64 msr, u64 *value);
>  bool hv_ghcb_negotiate_protocol(void);
> -void hv_ghcb_terminate(unsigned int set, unsigned int reason);
> +void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)=
;
>  #else
>  static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
>  static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index f937be1afe65..4b5e03f61f1f 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -209,6 +209,7 @@ static bool __dead_end_function(struct objtool_file *=
file, struct
> symbol *func,
>  		"do_task_dead",
>  		"ex_handler_msr_mce",
>  		"fortify_panic",
> +		"hv_ghcb_terminate",
>  		"kthread_complete_and_exit",
>  		"kthread_exit",
>  		"kunit_try_catch_throw",
> --
> 2.39.2

