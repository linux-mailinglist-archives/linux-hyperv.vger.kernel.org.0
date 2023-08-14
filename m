Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36A277C155
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Aug 2023 22:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjHNUKW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Aug 2023 16:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjHNUJz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Aug 2023 16:09:55 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020021.outbound.protection.outlook.com [52.101.61.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12552172C;
        Mon, 14 Aug 2023 13:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGt+SfiV5O96ZDMlnU9UwLsBakPPXKtZcbrHTDYxGhgUu9MFHPH2xRhNI/hECPqRboDKElbA21KsOAmZUPx8jcCEwm+qCkLYSeduirBpD40Ke29GZN06rCNFgRiB7NZfj4nBU5Eq/gjLXOJO3BqHyu7DLB8kvI4IsAA6l5yy5yK8vemO+MEwjQu7bR79/tO/VreLQ0Dj403p2cl8Dz6rHX28CbCra3GpPlMsJ2pxMG0FQZFdlCfppeZ1yorQlv7EIpX51Zi0xpfCFEghCGDXf8BuOiOGstMAGEQz2hE2JErduf1mqdhfwsbsCtG6/KnlVnkF3e2uNXfSVjwb0Jgzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZNDHNSPQJHJrM1rLY13b+W0CRG2/rgHHebcEYu+2ow=;
 b=VzBi9LVFFu6VkgNaEL3Yw8gpQ4Ik7GRnOwxGm3Yf9KW7cWnWB+c6G6EKkquQruldcFKZqpXLGA/WuV/qJJz6KUiWg6wfL+PQSFCbU0o5qr6XPag9z8qpxpdg+z5gM0SrdKeMwZyB2ZZz3TaLTmPwGzBGL5zxn6KCXk09edHusJF+sMoNg1cCNg3p5l3nc5hvVCKkJjqrMpZwEC79orq608GpyYE+mEUDZf6fYGoCLFCjcVpXxJbRdtdKsTmKOxp97OS8OiYzpHBeGK3tNgIQ795p6tDs2Pi3ZlyUPBv+RdGplUIzYcezfZG5KtQvuOB20MfOC1E+ULkQfKDd593e4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZNDHNSPQJHJrM1rLY13b+W0CRG2/rgHHebcEYu+2ow=;
 b=UruQqPsfEIhX2aKcSVCdicl1lanmcl3dOfO3Vgxjcm3ELN8VQwm06ropoEzE2w/VhluYMxftW/hWlNIjWe10DD5dbUENXPoryTCorEUESFe/WukRFNiji/hXf6osMzuQUX7HtgEVSqKeDfxOpa8P7KrNcGUx5ib+Zl+CzoCUpQY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1861.namprd21.prod.outlook.com (2603:10b6:510:17::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.9; Mon, 14 Aug
 2023 20:09:49 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a%4]) with mapi id 15.20.6699.012; Mon, 14 Aug 2023
 20:09:49 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hv: hyperv.h: Replace one-element array with
 flexible-array member
Thread-Topic: [PATCH] hv: hyperv.h: Replace one-element array with
 flexible-array member
Thread-Index: AQHZyRTXFp6yedDvhkSOqIWkI+ltNa/fDEuggAEcmgCACheS4A==
Date:   Mon, 14 Aug 2023 20:09:49 +0000
Message-ID: <BYAPR21MB16886B19D5E96933B1E9F6BAD717A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1691401853-26974-1-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB16888C4F0D90CB84716B49EFD70CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <PUZP153MB063512844F0E2FB075214C57BE0DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PUZP153MB063512844F0E2FB075214C57BE0DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ee73fe59-7a8a-4e9e-b0b8-3fcc6a8cbf7c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-07T16:50:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1861:EE_
x-ms-office365-filtering-correlation-id: f3bf199a-91c1-4219-128c-08db9d026a07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: djj9s0dlHsXC0+fM/BvU3DGSL5cSuMxSkAs0UMqVDQPnuluz9wTczU4MxI9jBjqJV11AwGNzZz1vD1SrPf1jJw/Z8nNCSYq5Q0pyisFSJRCMwG9T+AurZUl58FoYmPpL3EdcnpLzrEZ5owz+cw8T1B7zwTiAFtLG8DszS65kIFlg+2/hVskPLC1eJzNjVGx3LyW7J1aC4r06z5Y+6RTaQH7RTHKq+gREJh1DUkMi5oHTZEYtyq/nnYZBpSzss3ilPieYyHEKLvm3RvV1QpMTjA/IjWMMWIkjU+OtplVzNY2zfEuzbMWqJwWfeTiIKPLOEUVLxTi67SCXnkKIHy/UXNzROtnDCO+39H60YUm8Lcpa/HwcxXV+z0qKAulTYGpopD/a5WJzOgIRgoh7v2QN+8RY2v8SAKqHYT2z9nCfSnEmU1tOFYytaayivZNVO5D8aG6a26dHyPncJP3cbpTvZhNZflhaweV2t5tcD1fEGKwjjn/vwChFoq6UV0PC40Uu6TUyg5jd1e+1Ks/qu+fC18T6OMh83ZBjY9u3jF4p15/Hrq3GgWm4VS6TQTlVgQOIEySo7lHj1f3NGytKKmdgNlJCGiBTfsT4cwifXrJqG7miASMGi3Rc1Yq6GWOJFnnil75IQhu0IItCbC6D3o6BuBJnu/5lCOH+xLsLcW5v71hIHRL39ASSVbCO9w2fYf35
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(186006)(1800799006)(12101799016)(6506007)(54906003)(10290500003)(110136005)(478600001)(83380400001)(26005)(53546011)(71200400001)(55016003)(76116006)(7696005)(9686003)(8676002)(2906002)(38100700002)(38070700005)(82960400001)(52536014)(8936002)(5660300002)(41300700001)(316002)(6636002)(33656002)(4326008)(122000001)(86362001)(82950400001)(8990500004)(64756008)(66476007)(66946007)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gjm2Seqz9X3e2sorr4no5DTUNxquqk1A4mSj8rMN7qypXlx1C9Ccwru8NJ1l?=
 =?us-ascii?Q?Wod6i26wiyD8cOqeFYWcNVu8bThyKkvR48autf1DTK8ULCgwTugRRRyHhyqS?=
 =?us-ascii?Q?niUg6C+kbyIAxJ31ZhWjTDUSCpgicglAsq/zww08wQ11iizQcYD/j+g+rwbk?=
 =?us-ascii?Q?Fuj25uVPq7b18nnlaT6olc+KR41nTGPeTIV4wKJeOpyaIVbP481CPljkrEJu?=
 =?us-ascii?Q?1LHBJif3EbV9iZjaBsipQilexUVTD3vmlls0oSKrG2o6hduy5bmabxLAnHtm?=
 =?us-ascii?Q?efQSFd+KgTot0soodmpKUODh5mXkTAEflz5j4Qz+nkYQ5bDkBgzPBBIgFIyz?=
 =?us-ascii?Q?OkguZxgEWuZ/syj/wpaRKIznAnPhJUQi0/vVLq+00c6x/rHws3stP+QWoxwh?=
 =?us-ascii?Q?lv3fGv97HXq6kAWzHV8+N4JadDaAN/581itKVJJ7BuIX5Vq+9DPPiGFC0VqH?=
 =?us-ascii?Q?YIYk8FWor5ZkFU4VHcCXkRG65XrDmg2BLBkkszao8AFn4rz0SY53W+/nYx2k?=
 =?us-ascii?Q?7+GCsnMLvvhyUt/uByx9meDkGoE8QWxTvADT8VlETFyWCUqjayHgbb0QOuSg?=
 =?us-ascii?Q?BkSb+u4spS1byXqc7z1gyuYCSMF36xht6LIpZ4uys8xxg5/OpYPmZMSCj8Xt?=
 =?us-ascii?Q?ySJzvGBn4AYJqa4UwuurHtkKz6IE7X4RueoK7bbvGWC7+E/Mq/3ccUJcm9Xa?=
 =?us-ascii?Q?HAkRAKe3UbqOuGWidZ/JgfHP+bqtMSVLcENxamRy+4cwdY+N5ER0XoK+Iyr/?=
 =?us-ascii?Q?xMG3pv6TjoTKFlABV/fznwMPIdZm/B8KJ8zETk8zrNgUPXusVdPJy6yj2xGq?=
 =?us-ascii?Q?afCJUGvCG2es7mflVKJ+ugRisG0zST7fs6NgEO6QPv0t0cFqxpWVszJ9VY2K?=
 =?us-ascii?Q?ZsHmjeMhPmPpbHYjMZF0TO7q3g4bzgOuwIQMBxrYrMEWuMJQliNdD6nOyhHv?=
 =?us-ascii?Q?zdo1CtPCUypLJ323rD+9ptRJ08NQXhGJnvSO42gJFQpUwjANTLvqWAfM/tfT?=
 =?us-ascii?Q?gowwM4pHTsK7W/x3HOVqkTTv+1LLKM6K8JXYIqgG1C95zX+iEQsoENWs9sCf?=
 =?us-ascii?Q?SoudL6LkgdXLqilTKmXK0cQcOUADqxpLBTsh+8GQjqivVq/y7GlLEn/3BR8G?=
 =?us-ascii?Q?qmqr2qLdiQ1wwXgl+V86MUHAPQQ/RtdxP+q4hHXdTN2DFGk7yLeXHvg72BK+?=
 =?us-ascii?Q?amBuIb6oeF6PJTXoQnkGsPSVe13ZTRdeJmhPLU0q68B+4Gc4OU6oYfiMs2i1?=
 =?us-ascii?Q?yVqF0TgtnFZdIrB94Cd3sQktP0I0jimnEK+weAzLh4OqFAHrE0PmuZIQGYuk?=
 =?us-ascii?Q?Slkx6Pci+83zzDU2YDa+/9+jN6buOHAyDaLs9LcOHJn/rq94poPEEeUIM3PZ?=
 =?us-ascii?Q?7OCgS9CE06UhVMlV4L8sW6PEDRGA1p89gkgJpt8cWcuPeH4MELtECto29wDa?=
 =?us-ascii?Q?jP7V/BNZBQHhAgsPN0J2P8+x1BWlz3q+3AawESJdord4PRf1yZ71y0KJNMuj?=
 =?us-ascii?Q?nPrEAESXOs2+CBdxdPwc+DO0XEjO8OgFr+48Th6IvcozsHf3rrNQIfFcrhwG?=
 =?us-ascii?Q?FPkF40dAVO1c+UI98sLupmu92bfNTaNHNicl4IjkvEYbIFnVI5ZuOcKn7J1E?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bf199a-91c1-4219-128c-08db9d026a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 20:09:49.6833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a4UQyDzsAzcodr3GYrf5ASHbhkULsw2TBl8r7v5ibNr9u6xd5WVxkEP5FXWisBwfExyZhE5x8NGaLBx56EK6lMsq2xZ7QW0PdRXcLr4nSqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Singh Sengar <ssengar@microsoft.com> Sent: Tuesday, August 8,=
 2023 2:49 AM
>=20
> > -----Original Message-----
> > From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Sent: Monday, August 7, 2023 10:26 PM
> > To: Saurabh Sengar <ssengar@linux.microsoft.com>; KY Srinivasan
> > <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> > wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>
> > Cc: linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; Saurabh
> > Singh Sengar <ssengar@microsoft.com>
> > Subject: RE: [PATCH] hv: hyperv.h: Replace one-element array with flexi=
ble-
> > array member
> >
> > From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, August=
 7, 2023 2:51 AM
> > >
> > > One-element and zero-length arrays are deprecated. Replace one-elemen=
t
> > > array in struct vmtransfer_page_packet_header with flexible-array
> > > member. This change fixes below warning:
> > >
> > > [    2.593788]
> > >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > [    2.593908] UBSAN: array-index-out-of-bounds in drivers/net/hyperv=
/netvsc.c:1445:41
> > > [    2.593989] index 1 is out of range for type 'vmtransfer_page_rang=
e [1]'
> > > [    2.594049] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.5.0-rc4-ne=
xt-20230803+ #1
> > > [    2.594114] Hardware name: Microsoft Corporation Virtual Machine/V=
irtual Machine, BIOS Hyper-V UEFI Release v4.1 04/20/2023
> > > [    2.594121] Call Trace:
> > > [    2.594126]  <IRQ>
> > > [    2.594133]  dump_stack_lvl+0x4c/0x70
> > > [    2.594154]  dump_stack+0x14/0x20
> > > [    2.594162]  __ubsan_handle_out_of_bounds+0xa6/0xf0
> > > [    2.594224]  netvsc_poll+0xc01/0xc90 [hv_netvsc]
> > > [    2.594258]  __napi_poll+0x30/0x1e0
> > > [    2.594320]  net_rx_action+0x194/0x2f0
> > > [    2.594333]  __do_softirq+0xde/0x31e
> > > [    2.594345]  __irq_exit_rcu+0x6b/0x90
> > > [    2.594357]  irq_exit_rcu+0x12/0x20
> > > [    2.594366]  sysvec_hyperv_callback+0x84/0x90
> > > [    2.594376]  </IRQ>
> > > [    2.594379]  <TASK>
> > > [    2.594383]  asm_sysvec_hyperv_callback+0x1f/0x30
> > > [    2.594394] RIP: 0010:pv_native_safe_halt+0xf/0x20
> > > [    2.594452] Code: 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 =
90 90 90 90 90
> > > 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 05 35 3f 00 fb f4 <c3> c=
c
> > > cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
> > > [    2.594459] RSP: 0018:ffffb841c00d3e88 EFLAGS: 00000256
> > > [    2.594469] RAX: ffff9d18c326f4a0 RBX: ffff9d18c031df40 RCX: 40000=
00000000000
> > > [    2.594475] RDX: 0000000000000001 RSI: 0000000000000082 RDI: 00000=
000000268dc
> > > [    2.594481] RBP: ffffb841c00d3e90 R08: 00000066a171109b R09: 00000=
000d33d2600
> > > [    2.594486] R10: 000000009a41bf00 R11: 0000000000000000 R12: 00000=
00000000001
> > > [    2.594491] R13: 0000000000000000 R14: 0000000000000000 R15: 00000=
00000000000
> > > [    2.594501]  ? ct_kernel_exit.constprop.0+0x7d/0x90
> > > [    2.594513]  ? default_idle+0xd/0x20
> > > [    2.594523]  arch_cpu_idle+0xd/0x20
> > > [    2.594532]  default_idle_call+0x30/0xe0
> > > [    2.594542]  do_idle+0x200/0x240
> > > [    2.594553]  ? complete+0x71/0x80
> > > [    2.594613]  cpu_startup_entry+0x24/0x30
> > > [    2.594624]  start_secondary+0x12d/0x160
> > > [    2.594634]  secondary_startup_64_no_verify+0x17e/0x18b
> > > [    2.594649]  </TASK>
> > > [    2.594656]
> > >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > >
> > > With this change the structure size is reduced by 8 bytes, below is
> > > the pahole output.
> > >
> > > struct vmtransfer_page_packet_header {
> > > 	struct vmpacket_descriptor d;                    /*     0    16 */
> > > 	u16                        xfer_pageset_id;      /*    16     2 */
> > > 	u8                         sender_owns_set;      /*    18     1 */
> > > 	u8                         reserved;             /*    19     1 */
> > > 	u32                        range_cnt;            /*    20     4 */
> > > 	struct vmtransfer_page_range ranges[];           /*    24     0 */
> > >
> > > 	/* size: 24, cachelines: 1, members: 6 */
> > > 	/* last cacheline: 24 bytes */
> > > };
> > >
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > >  include/linux/hyperv.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h index
> > > bfbc37ce223b..c529f407bfb8 100644
> > > --- a/include/linux/hyperv.h
> > > +++ b/include/linux/hyperv.h
> > > @@ -348,7 +348,7 @@ struct vmtransfer_page_packet_header {
> > >  	u8  sender_owns_set;
> > >  	u8 reserved;
> > >  	u32 range_cnt;
> > > -	struct vmtransfer_page_range ranges[1];
> > > +	struct vmtransfer_page_range ranges[];
> > >  } __packed;
> > >
> >
> > As you noted, switching to a flexible array member changes the
> > size of struct vmtransfer_page_packet_header.   In netvsc_receive()
> > the size of this structure is used in validation of the VMbus packet re=
ceived
> > from Hyper-V.  Changing the size of the structure changes
> > the validation.   The validation code probably needs to be adjusted
> > to account for the new structure size (or the original validation code =
was
> > wrong).
> >
> > There might be other places in the code that are affected by a change i=
n the
> > size of this structure.  I haven't fully investigated.
>=20
> Thanks for your comment, I wanted to have this discussion.
>=20
> Before sending this patch, I was contemplating whether or not to make thi=
s change.
> Through my analysis, I arrived at the conclusion that the initial validat=
ion code
> wasn't entirely accurate. And with the proposed changes it gets more accu=
rate.
> IMHO it is more accurate to exclude the size of 'ranges' in the header.
>=20
> With my limited understanding of this driver,  the current "header size v=
alidation"
> is only to make sure that header is correct. So, that we fetch the range_=
cnt and
> xfer_pageset_id correctly from it. For this to be done I don't find any r=
eason
> to include the size of ranges in this check. With inclusion of ranges we =
are
> checking the first 'struct vmtransfer_page_range' size as well which is n=
ot required
> for fetching above two values.
>=20
> Once we have the count of ranges we will anyway check the sanity of range=
s with
> NETVSC_XFER_HEADER_SIZE. This will check "count * (struct vmtransfer_page=
_range)"
> Which is present few lines after.
>=20
> For a ranges count =3D 1, I don't see there is any difference between bot=
h the checks as
> of today.
>=20
> Please let me know you opinion if you don't find my explanation reasonabl=
e.
>=20
> I don't see any other place this structure's size change will affect.
>=20

Got it.  I have now carefully looked at the netvsc_receive() code myself,
and I agree with you.  With the 1 element array, the validation in
netvsc_receive() could have generated a false positive if the range_cnt
is zero.  But I don't think a zero range_cnt ever happens, so the
false positive never happens.  With the change to use a flexible array,
the validation is now correct even with a range_cnt of zero.

Please add a note to the commit message for this patch:  The validation
code in the netvsc driver is affected by changing the struct size, but the
effects have been examined and have been determined to be appropriate.

Michael
