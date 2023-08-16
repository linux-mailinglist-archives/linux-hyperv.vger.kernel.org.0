Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9901977D984
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Aug 2023 06:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbjHPExf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Aug 2023 00:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241741AbjHPExD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Aug 2023 00:53:03 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD272268F;
        Tue, 15 Aug 2023 21:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCPDdtw+bt6/eCCyYoayUwHiu0QFwO2KzDTCVI5r0qT4ZGp/NZxDRye4+J0motYsvOgTmDwHC9gcnC9m0nIT0GPyydF81eDhnv8L1aLn4Z96/vE8XZr2Pnw2n/h2HIDiKreHfUrW8JqVcisOl+M7Sv0oWBpGbULdRPv9g3TH10R3simbORYiOz3jkPeyzi1Ws2ql00xzPWI7BqmiYhTwgKuKXU5yNiE4KkGXvG77zF+DzPhXo0gv938xYp1gq94Uf2jJKtbQyF+1nUF+Sceez8SVc0nUCOXL6y/gJt9zZ4sM67neUHobOvHGAT7Fh9PB0wsedEEPoFdaGzjKgEAN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXQ/H1p1fWbkSCqbR4LIe8BI8D1UbfKQqh3/r3XLSas=;
 b=KRte+Tvd28aLwY7+g3k+47I7/+hkW/WPi+ooKcbgIHYHMYKprTyf8D35TSC13zFUNJ0Aqecy3Hj1RzuA0aA9792ih92NV/TVUjZGxOhvDjnG+Z7QG6NV2SZtUA/8NhSGUt0ggYI027Kb4N03USnOp+O0xNjto2pKpKMd8DtHgN2gJEuvYsaNi3SKtGiC7Ar7hoHhOiV3wefS8l/QMQq0YJOWW+5ZNaFsRwwH612i2aexlRzIzecrP+CFvoz/dTCPNvy9hY3iC5HzIVnuH40VRhoqRCmXb860FkJlC3PgyGyTQo9AFN45ovY5Xu73LCotZ6FKGlJ04l3jF4meHQ05og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXQ/H1p1fWbkSCqbR4LIe8BI8D1UbfKQqh3/r3XLSas=;
 b=T7yYdrr7XHOko/XElGQALWYXyOpfjEPrJ9BuSizDHpzQj9xhwVvdPUUG3JtgxtoPhcKOkj/lqpAQN4EaRMT9Z8cUk/OPExy8Bb4FVD2YFyQvjPeBMn9iURvfzbwWv2dgCaQfHes2WRSLnrNLR+rISovczjNIsIr/KuW5LbbdZHQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY1PR21MB3966.namprd21.prod.outlook.com (2603:10b6:a03:522::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.9; Wed, 16 Aug
 2023 04:52:58 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a%4]) with mapi id 15.20.6699.012; Wed, 16 Aug 2023
 04:52:58 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH v2] hv: hyperv.h: Replace one-element array with
 flexible-array member
Thread-Topic: [PATCH v2] hv: hyperv.h: Replace one-element array with
 flexible-array member
Thread-Index: AQHZz/r9DRtnuTIq1k6VfC+howReFq/sWqOw
Date:   Wed, 16 Aug 2023 04:52:58 +0000
Message-ID: <BYAPR21MB1688FA593FF45C7BCCD74BB9D715A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1692160478-18469-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1692160478-18469-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9454721f-7d9f-4f71-986b-2afefcf3caac;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T04:51:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY1PR21MB3966:EE_
x-ms-office365-filtering-correlation-id: 7616c32b-70b6-4fb8-baef-08db9e14a9aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sadLoJt5oJOLSaDG6YONfrMug6Ivu6OG5HnMfru95slLuQ3YZzVx69/UMN/Z5XG+JsaRf3TnowGRlo+KQJ4cKvMREO7M6XgfuOvG7Osjvli0RS3WGUDla+Sq7QuLRJ8JY4fmuqdiO5AoWQVmB+cbIeGb4lO0iwrAItmDYC/93OyzacQID37wYU2hVTwAIz/sTs0mAxf3HeOspbYwR0U6noPqgiq2oMWxwXVjjohdqGeyjZq2U78IUkIqgD7Zomk011W42sjobfYrKqeDwnRFlPOt+EC/FLfL3RPXDsnbw5mfzHuGNLW8C9dTY/cbiqjfWU9Yx8fN3I/lJPQDt+QKVjwm6iC+zPLu9fGYHzrnNBR4RYjRIDLt6gZ6vklEdlxpSCMX3DUkOgHLgRqPwW+Ax+b7lkIzde3fQm49/YE1GBsPxLnMvXfWTzGYMfyugNKxDea9igqzp3lwaLQFDbFLhm6UM7KIXvqf6p7ZbZbDXifTTXXWHSiKfl3KRedksBJsVqFgLzBN8cgmdOq1AB36SYa0BqHmhcuv9DAwFau73TLeFmMUUQ8aiRDAJsqw6uCj3vwORzkHdvAVHhexO2INVE/2OgQVeIqnyEFG/RaqEYm5Nf9cNnqmUZ2wnxvbxAKCIGtwuaOES6yHftKz5EaePfMcNqgl7Sei0u7mMt5ANkALeYKadFOX8Puly7oC/tSC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(1800799009)(186009)(451199024)(12101799020)(7696005)(478600001)(110136005)(38100700002)(55016003)(6506007)(82950400001)(54906003)(71200400001)(10290500003)(122000001)(82960400001)(52536014)(5660300002)(38070700005)(2906002)(33656002)(86362001)(6636002)(8990500004)(316002)(8676002)(66556008)(41300700001)(64756008)(66446008)(76116006)(8936002)(66476007)(66946007)(107886003)(26005)(4326008)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/HXpZMbw1cx9yBPu/RM6yCPOhFt/MPHe5J8LxBxifu378JjSElzVAolU3ZiE?=
 =?us-ascii?Q?zTIl2JPIz01BvdNAyjCY2ovzgybNZ+O5TT/abCioyETfk/oom1sUFeNj9ixS?=
 =?us-ascii?Q?kW7H/YylYR5Pxe+Y04NWNVBJoIHoxNUdCc8Dvxnx/Ypqwot11gpIFZyYw58M?=
 =?us-ascii?Q?PHhHp/ior6+o+NTHar29Se1USw5Lvljsftt6LP4OlLUYcYkaoGQSrGwyrsPU?=
 =?us-ascii?Q?EkQ3HjldDY9x+WY9mqSWZotUcyNzyok7fbMZldWvBpYSnglf/cb3sqGeaEnC?=
 =?us-ascii?Q?1a8a33fGkHF404mKJdTe9wm+A7WN+y10gX+LiFUz/u2LGZTuzQub/DvRuwJS?=
 =?us-ascii?Q?lz6fg/OiZWsv1aUILAVZe2XlUFztQdoQuc5tfm/4O8CgQYyRRNc9LgD9+Vi5?=
 =?us-ascii?Q?/P219KYjZK4Drkbl6IWev2LveKm8w9xvIsBcX00HTmkTpchZ/QW87/keuxre?=
 =?us-ascii?Q?O+dSyDattEEK++tCeON+kRBs+sKt2IWVvl/730FsIp0V3YJreBKyiufhRPkD?=
 =?us-ascii?Q?v2ifVQotqJAYQ1tMqpcgWj/ZhLxVuDJHwUT1KvWka+KiXfvCxwMLc4+S9+vl?=
 =?us-ascii?Q?WXPsQp2+1dpT2HYws7XxJrgqm0fqFhE0fYC+MvjR1lKfbf9Y328GAfIpyxib?=
 =?us-ascii?Q?ssrixjr1TcjOSQ9F14BSt6C8dvhugOdAQTy166ccTgB4h9rPINr0DLbXl9dW?=
 =?us-ascii?Q?sUfwLRT+00TdldGXfjIcu6FYcjiG9J2fCv/hM6dCR4lyZmEHjvgm3ZyVMIPb?=
 =?us-ascii?Q?PvHO0W6vnkj9Hq3V5OvDwMlvCzEvvLMDoWz/yzzwWmPuXYKpMoD5l+pSAzU3?=
 =?us-ascii?Q?jkObjIaPDETL1RG/numJmnb3BssslQa0J4dm5jceqrbJYTnShrMzneVHdBk4?=
 =?us-ascii?Q?P8xncmrtV1bew+T9v5IqQRW0hCM7pJBuqBYBYJbWvAeAgviHFor7d93W6tb6?=
 =?us-ascii?Q?VF5GYOXd7x+s3DoFi8F0ymp576IWtalnqY1plmGLyk0ZwB9C8OewcCrKamz1?=
 =?us-ascii?Q?W9k2QCBiKWA7Z2maoJ6ADkO/ppqYASEn/wn7hg/43aXz+5MbKu5tYSFg5vPC?=
 =?us-ascii?Q?S0WCDMhIQKmJYKo3/Dd2SMuT02hOobiaawFTOAucisocEZezMgo5Z/N7Fl3A?=
 =?us-ascii?Q?BIPvdlY7mkApSjsLSfqLTZuMsXC+0EhPoXlPt8g3+6seLa/GsVAe/sqt3P35?=
 =?us-ascii?Q?zhqCatLvnXOaosV2h8wXP4Ww2+qxeW4lM3mNgv3xBprVlNxsgGITRllMQwkF?=
 =?us-ascii?Q?BxVQcwDSMsoBIi991wUuJRXQAbO45YWtp2NL077dkQenOPAQSDEmJ0ld8HJl?=
 =?us-ascii?Q?rCsnecy99FSDk1ce/8tlBTjVqEhxdNTQgyFzquygHnLi8gAjmSMTNmmMok5F?=
 =?us-ascii?Q?rDAiwqkIeEKilKjddBE7C7H4O0IZ8ABz+MS2tItuNrHf+nBfE977SKexjipl?=
 =?us-ascii?Q?ZZPhB4aw020u65lsN4lNjcIfMwSjyZVvWAiIC8dvag3Hw/qbmCdXqhoaBiMG?=
 =?us-ascii?Q?5YMey1IJMEJ3aJj1HFqijin2fQPX7s+Ba9IXadQHhRkJuThd/Pn51qkyn9xR?=
 =?us-ascii?Q?OteeK+ViMZEGyJu4Nc3CApMf8TnsoeSoA11+gqbrk0o3WjV8ZE2EpDdX9Kwb?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7616c32b-70b6-4fb8-baef-08db9e14a9aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 04:52:58.5596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQ/j4jvHkX9suGs486wHeSLjneh+m25/kgToNOVb607SXIa4S1TD7v5tuo3jfSrSXSk+MRqiSqjmbfYMXTSVytm5Zohhr7i+7YCwb6p/Z58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3966
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, August 15=
, 2023 9:35 PM
>=20
> One-element and zero-length arrays are deprecated. Replace one-element
> array in struct vmtransfer_page_packet_header with flexible-array
> member. This change fixes below warning:
>=20
> [    2.593788]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [    2.593908] UBSAN: array-index-out-of-bounds in drivers/net/hyperv/net=
vsc.c:1445:41
> [    2.593989] index 1 is out of range for type 'vmtransfer_page_range [1=
]'
> [    2.594049] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.5.0-rc4-next-2=
0230803+ #1
> [    2.594114] Hardware name: Microsoft Corporation Virtual Machine/Virtu=
al Machine, BIOS Hyper-V UEFI Release v4.1 04/20/2023
> [    2.594121] Call Trace:
> [    2.594126]  <IRQ>
> [    2.594133]  dump_stack_lvl+0x4c/0x70
> [    2.594154]  dump_stack+0x14/0x20
> [    2.594162]  __ubsan_handle_out_of_bounds+0xa6/0xf0
> [    2.594224]  netvsc_poll+0xc01/0xc90 [hv_netvsc]
> [    2.594258]  __napi_poll+0x30/0x1e0
> [    2.594320]  net_rx_action+0x194/0x2f0
> [    2.594333]  __do_softirq+0xde/0x31e
> [    2.594345]  __irq_exit_rcu+0x6b/0x90
> [    2.594357]  irq_exit_rcu+0x12/0x20
> [    2.594366]  sysvec_hyperv_callback+0x84/0x90
> [    2.594376]  </IRQ>
> [    2.594379]  <TASK>
> [    2.594383]  asm_sysvec_hyperv_callback+0x1f/0x30
> [    2.594394] RIP: 0010:pv_native_safe_halt+0xf/0x20
> [    2.594452] Code: 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 9=
0 90 90 90
> 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 05 35 3f 00 fb f4 <c3> cc cc=
 cc cc 66 2e 0f
> 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
> [    2.594459] RSP: 0018:ffffb841c00d3e88 EFLAGS: 00000256
> [    2.594469] RAX: ffff9d18c326f4a0 RBX: ffff9d18c031df40 RCX: 400000000=
0000000
> [    2.594475] RDX: 0000000000000001 RSI: 0000000000000082 RDI: 000000000=
00268dc
> [    2.594481] RBP: ffffb841c00d3e90 R08: 00000066a171109b R09: 00000000d=
33d2600
> [    2.594486] R10: 000000009a41bf00 R11: 0000000000000000 R12: 000000000=
0000001
> [    2.594491] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
> [    2.594501]  ? ct_kernel_exit.constprop.0+0x7d/0x90
> [    2.594513]  ? default_idle+0xd/0x20
> [    2.594523]  arch_cpu_idle+0xd/0x20
> [    2.594532]  default_idle_call+0x30/0xe0
> [    2.594542]  do_idle+0x200/0x240
> [    2.594553]  ? complete+0x71/0x80
> [    2.594613]  cpu_startup_entry+0x24/0x30
> [    2.594624]  start_secondary+0x12d/0x160
> [    2.594634]  secondary_startup_64_no_verify+0x17e/0x18b
> [    2.594649]  </TASK>
> [    2.594656]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20
> With this change the structure size is reduced by 8 bytes, below is the
> pahole output.
>=20
> struct vmtransfer_page_packet_header {
> 	struct vmpacket_descriptor d;                    /*     0    16 */
> 	u16                        xfer_pageset_id;      /*    16     2 */
> 	u8                         sender_owns_set;      /*    18     1 */
> 	u8                         reserved;             /*    19     1 */
> 	u32                        range_cnt;            /*    20     4 */
> 	struct vmtransfer_page_range ranges[];           /*    24     0 */
>=20
> 	/* size: 24, cachelines: 1, members: 6 */
> 	/* last cacheline: 24 bytes */
> };
>=20
> The validation code in the netvsc driver is affected by changing the
> struct size, but the effects have been examined and have been determined
> to be appropriate.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V2]
>  - Added more info in commit message regarding netvsc validation code
>    affected by change of this struct.
>=20
>  include/linux/hyperv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 3ac3974b3c78..5c66640ea8db 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -348,7 +348,7 @@ struct vmtransfer_page_packet_header {
>  	u8  sender_owns_set;
>  	u8 reserved;
>  	u32 range_cnt;
> -	struct vmtransfer_page_range ranges[1];
> +	struct vmtransfer_page_range ranges[];
>  } __packed;
>=20
>  struct vmgpadl_packet_header {
> --
> 2.34.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
