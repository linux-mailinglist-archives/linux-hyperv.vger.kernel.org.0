Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050EA772BCB
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Aug 2023 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjHGQ5P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Aug 2023 12:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjHGQ5F (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Aug 2023 12:57:05 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020018.outbound.protection.outlook.com [52.101.61.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7E61BDC;
        Mon,  7 Aug 2023 09:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBA5CcFFLlqtYCv6SGf8VnAKc7JJAt6YiO8U+leYTgWcARSpEjONwWoJVF0Z2kRTS1MwLf3tm9lY8Mfn2CDHAMSBiUj9Ku8FYlcxqHFC47/YnVVlWyS9lgi0qEOALKQ9STdFasHAvDm3h67YqbI7GQCIy25juQiE3mvMPBbhn4FzGCuhX0no6Wbm7oA9cmH0zZ7hTT3q8GO18MO+IheqHNsU1qSVpY06p0k88kdLSdXgKwiSvBUmg59Ou1sZKTWfdypYQqmkNQwYhlSU+QpFGlKtdV7VgOWGVP8omyOqwVFf0KA9HC/MFLAJeejP+InNBlRlw0d4t7tDI7Xf7rbhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCSdT5qnX6X1t8ES7Y8RffOjKO1XRNaKOY5OqUWihc0=;
 b=PbEDFCZtUN6bWfyUb+X8SYZ5rjHuB7pW9u2DwfL7RKjV04QjJL+Eqvn7RWaQ7DqQoXcT5+owSUZg8pOgHZUpM+cd8DhLx9GkQVWeA/tQ67gpj7/mgwYvpQ0wloVq2YBmmas0Za6VRi24m0y7HX28MEB6W1mO1Oz+42eat+1tpZXM1D0XCpC9bqst85FX9zA0ot3JslNKyko7nI6t6rzPr09VVw8hrpEOAMTCCJPREdCDQmYRc1mj3BVuM8rBYJXjmICQOOnkkXSAEPgCzMQESN4t3zj54spENEiRRCrmAh7rQS+3jpZeuWTS9y2Ug1scAyja0PzSUfHiII27BkARBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCSdT5qnX6X1t8ES7Y8RffOjKO1XRNaKOY5OqUWihc0=;
 b=T5aVmdEH3FhKvCmiR/gaeuui8V5GlOoCzpPVEGOQANfBum/0NZRAxw2QmoMhqebaJ+8Es+3jGD2EDHDo73zfKbKcypidJecQr3a9r5clZaGfqCwzB5hdhob8X6R8uJxTkY2DiCPl23Cs/twHnj6pe2H4k5VfOxXNNuv+T4v0c5g=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CH3PR21MB4018.namprd21.prod.outlook.com (2603:10b6:610:167::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.2; Mon, 7 Aug
 2023 16:56:28 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::33e3:b4a:54c4:6a07]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::33e3:b4a:54c4:6a07%6]) with mapi id 15.20.6699.002; Mon, 7 Aug 2023
 16:56:28 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH] hv: hyperv.h: Replace one-element array with
 flexible-array member
Thread-Topic: [PATCH] hv: hyperv.h: Replace one-element array with
 flexible-array member
Thread-Index: AQHZyRTXFp6yedDvhkSOqIWkI+ltNa/fDEug
Date:   Mon, 7 Aug 2023 16:56:28 +0000
Message-ID: <BYAPR21MB16888C4F0D90CB84716B49EFD70CA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1691401853-26974-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1691401853-26974-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ee73fe59-7a8a-4e9e-b0b8-3fcc6a8cbf7c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-07T16:50:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CH3PR21MB4018:EE_
x-ms-office365-filtering-correlation-id: 353bd654-362b-4b4b-2962-08db97673e30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KRp9yPqVSwcCtmHXn3bhg+R0TDKyYe2EH6zkNMJdU8akvvjN6hgoJYIgo2vTp7JGTvssw57h94lbfWxgzy8nn8l5AzicXCPB9dKPDbQH13WXAt7eaQt5sHfiL8BCPaNqw1cgXyDKz6jk7mj7+vts8zmppRt2zwtpfZetKukN60en1SFaqIuTuchXnqLFJksDDHCLICw2U6Lbr5N0iHf75Ip8DNvJMeT3J9AS1FBvNYYYTDW0FfSG7g1L3n5Id5YtP3KpnBVtOHaJUg9YHQ/FPFgknf3M1Dj6Zf+5g+g4EcKNy8hwGuCkWXPx90odEqp3nqmQFNOLRX4B942RWyU/h3p/gXZS7oCucQyjCpcfKbZly4cf0TKwgPD0PQG1V6p0yxvzPfahQM1oyj0w8zJvpUryVQ8Qie+WPZ/YuoDLEcGsBudLAdCxfjdnuSRzAYzyLGrd0dmSxUiEU24/5mmz2cj/k8QvUk7TthOEUuzTDx8ycPvu3EZawWELOCgD4ZW4OzxZHxAS6L5R1Z9Dp9PtLMCJkRV1g2VX2fwwJ8cg8czVpio6UhaeR7gi2/AulQ/oyvrPQQHRxXWe9VWUNNf7xWEa0CWGZ5SanENZtlV+JIj+4d2Vnl5/hrxS3xEXYbfRolCtn6WFY6eO+fkDE0lxtE4cJMPSTcQLMpPdYSVDPTbGU2GmdUrZGcNlT82+TQ53
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(396003)(376002)(186006)(1800799003)(451199021)(12101799016)(10290500003)(8990500004)(478600001)(54906003)(110136005)(86362001)(6506007)(107886003)(33656002)(83380400001)(26005)(82960400001)(82950400001)(38100700002)(122000001)(38070700005)(55016003)(7696005)(9686003)(71200400001)(66446008)(4326008)(6636002)(64756008)(66946007)(5660300002)(8676002)(8936002)(316002)(786003)(41300700001)(76116006)(66556008)(66476007)(52536014)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wOD9LlMmNvt97Ve9MR3xiJDH3TGM3UiRFFB9yAuaGf79o++6zZwbMtjSL1Hu?=
 =?us-ascii?Q?6MypDOd0zNHYUBgNtPvCDrox8jyAWgE7RNpu0kc4gpDSbBiid6QUWhkjY8/k?=
 =?us-ascii?Q?PZvuEH/I3VZ28SKLhSdyQEWHW9ryBWtGpuTkcO7+1Xe4F+ZTFULB+dOMoo+j?=
 =?us-ascii?Q?F6MNP2yHhfijMOBxSa5Psf0kfU/k6c5ETX0sZ7nvNTk9lKJskYzxkpvqbMYA?=
 =?us-ascii?Q?szYbxRvq8vvbgNh02sVf484ecf6gWlzUz/Ni5W//YXDSkExLzEDoZyEDL4Ci?=
 =?us-ascii?Q?J8jTn7KG2fbs5oN4zjEcMUw/gC0EwtlI5jwKCKFqJj48W7OrHvZGxcyvC8hY?=
 =?us-ascii?Q?y/na47He+taMmPgU7WYLKUs+zEqCLHu/4VirLj5jkaRd2qVC/l00KVwpv2cf?=
 =?us-ascii?Q?++dYPN17/OFKTHZzReUo4Bbeq6LILcjv65CMzt+xz5xVONs79vEY2n3IGtDg?=
 =?us-ascii?Q?8ErN8jHDzJI9eV3d9iY4V8Q/O5RxjaPSe+slVo6tPZitZlGjp/qb4qTKYOrS?=
 =?us-ascii?Q?J4DL6qp53i/ss95RBSZsKt+UEuKKBVY2iP2s2KJRelbuDD8E6aFyNhaJbV+w?=
 =?us-ascii?Q?oUrNiA3gbjmJTvyFmwJXqB6Ggj50LJDEfNofe556D/8Awrl/7/EoE6ejAwhn?=
 =?us-ascii?Q?lF0TIQidwMOUFiWGr/tMI1Z1Md/elL0gHyMFmAUZNOysbNcHWpaYujYFYeVW?=
 =?us-ascii?Q?nY2k+2DPguzhSUkk8EJg4FWnFTrxgGwGXXJmAC8slaTnbt1exO5o2kvKQELT?=
 =?us-ascii?Q?HD5iPeH5GA9mwG+llTmhNjYjtwerZQI92xwqjGrGVFeEYSCBPZbkNPl5CnY2?=
 =?us-ascii?Q?1Mq8XhTLUACI7KpBzVYcEfe8nZJWq5UU7AskCQ41Z/jBjaVXdipmGCZ0EAlF?=
 =?us-ascii?Q?+HCtlRDWdPHL9CO95p/7BLCLsUx/Q/VevolS+6nd3lNkDkQdD5yoKbnYlQ1/?=
 =?us-ascii?Q?oXwR++tD9GCmY9zoBJ8JVHnditrHn+guiKRalMsdhV3+UD85+eiXLNRPqGIh?=
 =?us-ascii?Q?qySermQ6iKjfS/EnCBIAAItFlUkaGANzS/5wETTiE34P1AWiVDXCxG4dq+zQ?=
 =?us-ascii?Q?LOutpGz01RRWCvwF5z0Yz0NtXZWykp7kPE7SqiXBXEvGNZ0oqd53tarWW1GB?=
 =?us-ascii?Q?la7IgQebVXx+gtjGMzkQL2D0gXpMpduJvZOeqX67tR5SYMl1dNot/koU6t3u?=
 =?us-ascii?Q?rSfsH+A0yGuB1A7ue2NPASyV+WYCCLjk211ewxAi1qzf2Y4PMu+EHSNrXMan?=
 =?us-ascii?Q?NBzO3ItdEywF6piiW7nuCrcG0SXHySsQJ48EQ1CfU24r7NoT5mUJBfttsKQl?=
 =?us-ascii?Q?g86mLd4WkMkgi8a6g7kOgmfKEGV4xp2yoB5p42RpKmE4b9YmKGXhsrtu3oJg?=
 =?us-ascii?Q?qivWiOs+TxaFueaGgB+vPdOtcBvIfIAQtA8LvT6cXeoVtGP9Ya6EY0g2l6D0?=
 =?us-ascii?Q?LY8ZziS6/I2IUSvhmnzu2jDpDyBKoO611edeeSF8cQtChhnccZD/2sCLZTK7?=
 =?us-ascii?Q?a2fyr4GVici3orAprqAzXoGZ2VNn0hF+7yYTysz+f8/Kuvt0XeDij3pRLOdH?=
 =?us-ascii?Q?nPg9b6cIK5YxkhCI9YL2zsrH2wgTwc5/ZrMXmU6RJ9S2KeheFwngh+RTw6hw?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353bd654-362b-4b4b-2962-08db97673e30
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 16:56:28.3419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Y1tv7ZXDs8pZ/qyHXEc03d7ylz+BVkyho3Y98G2Vvayqg4zYAIXAInJ+/wuNT9UL9aiYEl8w1eW0poGXNSg9/LJIYc0ZLqEcuR29eL3m8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR21MB4018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, August 7, =
2023 2:51 AM
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
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  include/linux/hyperv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index bfbc37ce223b..c529f407bfb8 100644
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

As you noted, switching to a flexible array member changes the
size of struct vmtransfer_page_packet_header.   In netvsc_receive()
the size of this structure is used in validation of the VMbus packet
received from Hyper-V.  Changing the size of the structure changes
the validation.   The validation code probably needs to be adjusted
to account for the new structure size (or the original validation code
was wrong).

There might be other places in the code that are affected by a change
in the size of this structure.  I haven't fully investigated.

Michael
