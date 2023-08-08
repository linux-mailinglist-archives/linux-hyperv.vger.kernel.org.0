Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D21773CB0
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Aug 2023 18:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjHHQIz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Aug 2023 12:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjHHQHD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Aug 2023 12:07:03 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020018.outbound.protection.outlook.com [52.101.128.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A11072B7;
        Tue,  8 Aug 2023 08:45:58 -0700 (PDT)
Received: from SI2P153MB0719.APCP153.PROD.OUTLOOK.COM (2603:1096:4:19e::11) by
 PUZP153MB0636.APCP153.PROD.OUTLOOK.COM (2603:1096:301:db::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.3; Tue, 8 Aug 2023 15:17:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCApDQAt0gA6sq0t4THE1QZqTFb3Ix2fGGyiLT/an4wbunD4o5AxYLehNSGdu2yvRN3bIyB950s9Ws8E2QpI0Ks2k35NTCiXLbdZJU9fRNM74L6eAxJxhKhOhTZOtQkIiYTEHlL3ht5dMPwGbxwMdL/dGYv0t2IuOwYf+KliOZCMjAzuZISRMjepzhaCIYuwMhinFRZ3oC1zEaG7ey9YCvb+d3PXOlJDIkPRxIojAd91iqHmcYZwhLh2pUAgo3OSXAk8992tantPfWpOv4w1IDecFrV2h7xjpgtLfndDBptXoTL9DtEhwyx/O7LUpq+HIJrN6N9hP9iKmcz2x4LvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxUHQQzPJSgkwcXEMCI7GMvk1R+vS+MQouh0jDxrt40=;
 b=nc9Mbg6TBJAYiTfsjXvgwto0ZHWqMAb8ayne2m5wl/1rUwJ1U0bEJQVn/fo9dXNF14E3jkF61y0j9/cCVVYgUY7EJ/E1AdqXsi0qoCtFzL0izJAzWd+LiIT6f/Q2Xt49XVrIHZGj5G6Sj0TsnQNILUG3u+0X75oCedyF6QnS1Bh63AwrKh1e2EeAQsODYFrKfYyD8rCiBQN15rc3T09xKsI/XKVBI1U/HRF8oA3vLV38w6Xb0cI3hbRscdwzSJ0UpgyQGfgv5vnjskMwoUZh4BTWRwiugs2/x9ILL4RjSQAf+bXXET/YiEJEU/3cKwR6prf9qSQN/ldEm+OSeS1brQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxUHQQzPJSgkwcXEMCI7GMvk1R+vS+MQouh0jDxrt40=;
 b=Hhy4aEh1Ow3wkflEWBEk4q4VWRawpai2w/qTjL8xexXwKMa67FmAS9vusTCTp565gzs4fT2FL7x8zA5NhCM4ig9dX0s/h29lNvOKsoHUyxIz1xb+PRS8U561PMAjIaytrNBeBLiy/gnWnwnPBCOM4f6hvG0OkIwapF0PUjFsAJs=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 SI2P153MB0719.APCP153.PROD.OUTLOOK.COM (2603:1096:4:19e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.3; Tue, 8 Aug 2023 09:48:49 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::97bf:be96:1ebd:5190]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::97bf:be96:1ebd:5190%4]) with mapi id 15.20.6699.002; Tue, 8 Aug 2023
 09:48:49 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
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
Thread-Index: AQHZyRSxPGtis/WiUk6q7r4g1TQVD6/fDg0AgAECfbA=
Date:   Tue, 8 Aug 2023 09:48:48 +0000
Message-ID: <PUZP153MB063512844F0E2FB075214C57BE0DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <1691401853-26974-1-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB16888C4F0D90CB84716B49EFD70CA@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16888C4F0D90CB84716B49EFD70CA@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ee73fe59-7a8a-4e9e-b0b8-3fcc6a8cbf7c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-07T16:50:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|SI2P153MB0719:EE_|PUZP153MB0636:EE_
x-ms-office365-filtering-correlation-id: d3a00238-c180-4a6e-e8bf-08db97f4aa2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4IaQVI8NbF7DPgjxY/wh8vuDsnb4GSGl1TPzoCRF+n/pL0xCzWbNzZ47y4oesRnV1FtJPTwJOemSnuv4n8W3ltrw1BiEl5k1w9mzkbc7+rmRMxHlH/W7AJkM8UzlR+Jxd3hx2kzqG2WuLQ/iISCTPereknF0u0Rmn2MUVcC0QTDGrHa+Kv0T+b/9Am8+nDYdic+ek9A4Vu7f2UwynDaJWIzuMz8e8oJGkJ90+MB3Z75lMQ4wj6yKboOCEfij47bjONzhUgbcd0UMkzng8M9dsNuQDQjiTd/Kv9IUsQ1wn7lPaqJp7H9Ssb5XlgEUaxOiAuC2lpHuMsbisH63MTcEqlEskDq+ySRarziwgbr8Kth3D9zq9hosuwnPzbA74UNnpKSbiI861ZT8oCJwHTMXfP6MhS8EIZsEP4V8FDqAZL71ptttiHED5rmybqdyaoJROkTbHahX3OI2EQdQbQYy/s9uxDlW71thvWt+mZKNTS5Eio57bUYsXXyoV12Vf8xZD5QmbQUeM3sqrg3OwhVFtNi1hYT3U5ikI21FEintWefnnLBdw56g0kTWA4VNp9eaWrnWI3SenGjOWCt8WTV05WZLuqZkH8pVyKHVAgTPOjjZllPXL03GguRvTsLE4e+l1F3k+8xtSjU0iDnOlLYlbZTSqJSDyMvXXvpnkcpbD7xSLWtXnjBaeIzMOXQkxf9w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(366004)(136003)(376002)(1800799003)(451199021)(186006)(2906002)(8990500004)(71200400001)(82950400001)(82960400001)(38100700002)(122000001)(53546011)(6506007)(83380400001)(8676002)(52536014)(66946007)(5660300002)(66446008)(41300700001)(66556008)(33656002)(64756008)(66476007)(76116006)(8936002)(4326008)(6636002)(786003)(316002)(55016003)(86362001)(7696005)(9686003)(38070700005)(54906003)(478600001)(10290500003)(110136005)(12101799016);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bjvJqwX/bKt8xvcdDR+bB+AU4s5MNkIXdMC8P52aNiiW3RzSlyOS0uQ6Vico?=
 =?us-ascii?Q?9pmnstv4M8D06V9qm729tzzpSmeVYa/iVsYXJEG41qJOqeIF3zDgYnTQwJrm?=
 =?us-ascii?Q?eAOkuldGRegXrNOUDF4a011ZrouwfEeniYUn2KmvlZkG+O2gNJMYJ0iydz8T?=
 =?us-ascii?Q?3nphQUfzuLQPYgUV2VwZBhEahJFPb53K9a1FReZJdkf/v4PJ4XeetRGpu3A8?=
 =?us-ascii?Q?3KhkmyIjQCtGQnRP+wdOs+nK6p3lguzVIAmpeO6IDYZ22K7Bx8qa+69hLcGx?=
 =?us-ascii?Q?r+2vUt/Bkf+amHUWVDIqknczskyKqNYCq/CVJJJQlOF4WAovGPWIjO1eS679?=
 =?us-ascii?Q?cc9YoT3VVpZjC5ApKHtAwFb9Da1200CX5V9w+1cIwCXLKSxM5/rHdyVnJTEV?=
 =?us-ascii?Q?TYCLWd4WBfi0B7U8GI0zfB9jr2fr9qTLKKqe4KSxX5crXP87PW72S/g9/knf?=
 =?us-ascii?Q?QRU3xCx7MJjElrP44BlHvBHzP/9evuYHMSImfMZrXFDTS7DLfy8AA+HAL3ST?=
 =?us-ascii?Q?5xofrrDYXDP3GIGY33h2bDxbaJEXcKeKDITFWTsrDn/0btBeYyUlff4cPr4B?=
 =?us-ascii?Q?ThnBA/9x+72ls2x65wsLCp9AANio5doEY+5AYcAOcgf4XtWs9Iyb91Uj08WB?=
 =?us-ascii?Q?2dEXXcBp0q1hdgexk/Vxy03aBldiWXlhUljzPU/HH56EQJQHTOLjDvzeYjZX?=
 =?us-ascii?Q?M4QsA/9uM5NQsPHK3ed7Mye6pFzU+Hk5Im6fGX2ix84tVSGoIwFM7gbaB4Xp?=
 =?us-ascii?Q?SmrWIy8HZbiUOZaM97+I/uD9o8y1I5UGnhk4Yc/LebXd0EOsbtQPAFdaJGO/?=
 =?us-ascii?Q?WBNhgUJI5mcCG9PE9WntznaZ3nfShUjS5cjM/fSVkF3ZAkC70sW4HSfRuAwz?=
 =?us-ascii?Q?w4hVT06OJJn/yfH6K6eBZJoFNz8S5NCCHIzuETN8yt1OnOn36w0wZD9nVrCi?=
 =?us-ascii?Q?+w2Xjs4i39RBvrGNVdnasONBXMsfoFDw6hyvRAUyqVF/4b6K2s2uxGOUPTrh?=
 =?us-ascii?Q?+0tqViQrXoijrxgCzFITTPLWX8AmaC6lCO6rdnTi62YJQz6V4mPSCQkLjeee?=
 =?us-ascii?Q?D+ou0/qaKujdlL85VJ3eRC3IHsOLBH5/nnB9LQVxNWi0XHhKA+MKYfVWZWyM?=
 =?us-ascii?Q?XL39FWdozJ63jNJcf10E+aC7WFE+tFQDeceM7QjOhr3z2dHfmBHyPGgHhIbg?=
 =?us-ascii?Q?+P4e7xpZkUdBJH5kKEpbbKeUJrAJhatRj5tun17JNKjt0NXr0cbuCe6Cilj8?=
 =?us-ascii?Q?w77VLFvpFxCnJZwVjif9h4/tSstrfFNHv7nWSc36BgEHg11HXjihx2CKM9hi?=
 =?us-ascii?Q?kbBShZgA8v/JHsonYBIkrphFErE5CZBHheimbuAHVWoS62IS+65e1VmPOcA5?=
 =?us-ascii?Q?ORIHqkVxiD/5ot6x5Sj/EmXnckMbQ9ZKuRbelSU2yfkuXa8YnHqEFY4jrw6Z?=
 =?us-ascii?Q?zof2NtOUOy9/girSqfS+NbHsPw26bn52eC22ld3qC3zAKEChJjlXCI9HrJ8Z?=
 =?us-ascii?Q?jL5fu4gp+Zsyr0riCw/CXGlO8RZKnOn1kjeq2ChLHqalkdu2q1svO8uFQl4r?=
 =?us-ascii?Q?vNd0gEcqntKdb43sMZEk80VGFUeizgEmtC9VSUV9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a00238-c180-4a6e-e8bf-08db97f4aa2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 09:48:48.5661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0CKmvJ72VXUuMbDjoVBzKT6J+8OCyfDh0qyJD77fmf+ZOkK1rrHLHCm8M4SFRGUqrTmU8QnEizMDHRTJDDEPWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0719
X-OriginatorOrg: microsoft.com
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Monday, August 7, 2023 10:26 PM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; Saurabh
> Singh Sengar <ssengar@microsoft.com>
> Subject: RE: [PATCH] hv: hyperv.h: Replace one-element array with flexibl=
e-
> array member
>=20
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, August
> 7, 2023 2:51 AM
> >
> > One-element and zero-length arrays are deprecated. Replace one-element
> > array in struct vmtransfer_page_packet_header with flexible-array
> > member. This change fixes below warning:
> >
> > [    2.593788]
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [    2.593908] UBSAN: array-index-out-of-bounds in
> drivers/net/hyperv/netvsc.c:1445:41
> > [    2.593989] index 1 is out of range for type 'vmtransfer_page_range =
[1]'
> > [    2.594049] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.5.0-rc4-next=
-
> 20230803+ #1
> > [    2.594114] Hardware name: Microsoft Corporation Virtual
> Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 04/20/2023
> > [    2.594121] Call Trace:
> > [    2.594126]  <IRQ>
> > [    2.594133]  dump_stack_lvl+0x4c/0x70
> > [    2.594154]  dump_stack+0x14/0x20
> > [    2.594162]  __ubsan_handle_out_of_bounds+0xa6/0xf0
> > [    2.594224]  netvsc_poll+0xc01/0xc90 [hv_netvsc]
> > [    2.594258]  __napi_poll+0x30/0x1e0
> > [    2.594320]  net_rx_action+0x194/0x2f0
> > [    2.594333]  __do_softirq+0xde/0x31e
> > [    2.594345]  __irq_exit_rcu+0x6b/0x90
> > [    2.594357]  irq_exit_rcu+0x12/0x20
> > [    2.594366]  sysvec_hyperv_callback+0x84/0x90
> > [    2.594376]  </IRQ>
> > [    2.594379]  <TASK>
> > [    2.594383]  asm_sysvec_hyperv_callback+0x1f/0x30
> > [    2.594394] RIP: 0010:pv_native_safe_halt+0xf/0x20
> > [    2.594452] Code: 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90=
 90 90
> 90 90
> > 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 05 35 3f 00 fb f4 <c3> cc
> > cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
> > [    2.594459] RSP: 0018:ffffb841c00d3e88 EFLAGS: 00000256
> > [    2.594469] RAX: ffff9d18c326f4a0 RBX: ffff9d18c031df40 RCX:
> 4000000000000000
> > [    2.594475] RDX: 0000000000000001 RSI: 0000000000000082 RDI:
> 00000000000268dc
> > [    2.594481] RBP: ffffb841c00d3e90 R08: 00000066a171109b R09:
> 00000000d33d2600
> > [    2.594486] R10: 000000009a41bf00 R11: 0000000000000000 R12:
> 0000000000000001
> > [    2.594491] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> > [    2.594501]  ? ct_kernel_exit.constprop.0+0x7d/0x90
> > [    2.594513]  ? default_idle+0xd/0x20
> > [    2.594523]  arch_cpu_idle+0xd/0x20
> > [    2.594532]  default_idle_call+0x30/0xe0
> > [    2.594542]  do_idle+0x200/0x240
> > [    2.594553]  ? complete+0x71/0x80
> > [    2.594613]  cpu_startup_entry+0x24/0x30
> > [    2.594624]  start_secondary+0x12d/0x160
> > [    2.594634]  secondary_startup_64_no_verify+0x17e/0x18b
> > [    2.594649]  </TASK>
> > [    2.594656]
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > With this change the structure size is reduced by 8 bytes, below is
> > the pahole output.
> >
> > struct vmtransfer_page_packet_header {
> > 	struct vmpacket_descriptor d;                    /*     0    16 */
> > 	u16                        xfer_pageset_id;      /*    16     2 */
> > 	u8                         sender_owns_set;      /*    18     1 */
> > 	u8                         reserved;             /*    19     1 */
> > 	u32                        range_cnt;            /*    20     4 */
> > 	struct vmtransfer_page_range ranges[];           /*    24     0 */
> >
> > 	/* size: 24, cachelines: 1, members: 6 */
> > 	/* last cacheline: 24 bytes */
> > };
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  include/linux/hyperv.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h index
> > bfbc37ce223b..c529f407bfb8 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -348,7 +348,7 @@ struct vmtransfer_page_packet_header {
> >  	u8  sender_owns_set;
> >  	u8 reserved;
> >  	u32 range_cnt;
> > -	struct vmtransfer_page_range ranges[1];
> > +	struct vmtransfer_page_range ranges[];
> >  } __packed;
> >
>=20
> As you noted, switching to a flexible array member changes the
> size of struct vmtransfer_page_packet_header.   In netvsc_receive()
> the size of this structure is used in validation of the VMbus packet rece=
ived
> from Hyper-V.  Changing the size of the structure changes
> the validation.   The validation code probably needs to be adjusted
> to account for the new structure size (or the original validation code wa=
s
> wrong).
>=20
> There might be other places in the code that are affected by a change in =
the
> size of this structure.  I haven't fully investigated.

Thanks for your comment, I wanted to have this discussion.

Before sending this patch, I was contemplating whether or not to make this =
change.
Through my analysis, I arrived at the conclusion that the initial validatio=
n code
wasn't entirely accurate. And with the proposed changes it gets more accura=
te.
IMHO it is more accurate to exclude the size of 'ranges' in the header.

With my limited understanding of this driver,  the current "header size val=
idation"
is only to make sure that header is correct. So, that we fetch the range_cn=
t and
xfer_pageset_id correctly from it. For this to be done I don't find any rea=
son
to include the size of ranges in this check. With inclusion of ranges we ar=
e
checking the first 'struct vmtransfer_page_range' size as well which is not=
 required
for fetching above two values.

Once we have the count of ranges we will anyway check the sanity of ranges =
with
NETVSC_XFER_HEADER_SIZE. This will check "count * (struct vmtransfer_page_r=
ange)"
Which is present few lines after.

For a ranges count =3D 1, I don't see there is any difference between both =
the checks as
of today.

Please let me know you opinion if you don't find my explanation reasonable.

I don't see any other place this structure's size change will affect.

- Saurabh

>=20
> Michael
