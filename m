Return-Path: <linux-hyperv+bounces-986-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594EF7F0777
	for <lists+linux-hyperv@lfdr.de>; Sun, 19 Nov 2023 17:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1488E280D21
	for <lists+linux-hyperv@lfdr.de>; Sun, 19 Nov 2023 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024DA134D7;
	Sun, 19 Nov 2023 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BP8LzaWL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021006.outbound.protection.outlook.com [52.101.61.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A419131;
	Sun, 19 Nov 2023 08:24:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBQiI0btZaRu0T7J4i/QK4o3+jiTSm4MnoyjKa7X0w8pPTd3szWT5d2SIEw/OX8yldK8IiSXaLSEj1aRWE0kbazIezKRaduY1sx4dAOmKwPI56FRvCLaIvo40aKL3gkk/APhJYWzCZbtyXcM21omnul7wJo0PMUeR2D8Y506zl724F5ayZV4C2iPL83P+udWOWvzImrNjIFQzdtIO8iJOQKR63YJaTzqym9Rc9NVCar8iO2IkTbE/5mxdDLFaiM9/59FSvDnz3QtejAWFB9Kq6jkcUFUdVziIp1mDVuB1drsr71fiYcFCfjsrGIGh2JiDG1DJ3tm0sQ8CLeDOEetcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ByQuzVVgQ7XDxEa8L2lqDPPBojFu1D/u1EP8Sdc/uw=;
 b=O/vwiJbM3PDldpYAaP+BuPQKhCxNM5rHP+2WKH1ro5bfludxrsQ1uuLCEZ6fvMJ90+RkKX44+6d9atiKUYSuYxp0T53mT9vEgFh5ZtfFQMSrfzAQTRJWMHteKGrwipWxK4dW7wtiSRuFBE66RVqJICqrKlBeLqtwwfHDFjLwOdxkBm8zIjSIUXZ5rsPi2IFiXuVAysAlqIaaY/vsz+itpUFikT2tfYcUNRzMAEV2W31fei0BhL75JdkeDHYmeFUr5iyXaBgWRMhXeiRtGqhVPqAG/y2OqsGtU3d05rOOEbttg5nHUaCIoHoiOBrb72W98RsCr8zBUF4WVWLqRYcIDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ByQuzVVgQ7XDxEa8L2lqDPPBojFu1D/u1EP8Sdc/uw=;
 b=BP8LzaWLVBoq+DB4ZRLMdBXiSctvdOHOz6/x+oK59Q7f4Ykgrn2GkYM9KBT+WuKtvetQzEorsanvpEDCNRNEYrGT1GzZkBlIaP49wnqheYZjFhUu7KPF3j/X8euYFjEK88vplDLBcniTsfiS7v7PBzBcZMUB5FvVqZGnRSLU5sE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by BY1PR21MB3893.namprd21.prod.outlook.com (2603:10b6:a03:52d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.8; Sun, 19 Nov
 2023 16:24:16 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::d819:9f58:df81:2d20]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::d819:9f58:df81:2d20%3]) with mapi id 15.20.7046.004; Sun, 19 Nov 2023
 16:24:15 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stephen@networkplumber.org,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net,v5, 0/3] hv_netvsc: fix race of netvsc, VF register, and slave bit
Date: Sun, 19 Nov 2023 08:23:40 -0800
Message-Id: <1700411023-14317-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:303:b8::22) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|BY1PR21MB3893:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be39402-4d78-4812-2a5f-08dbe91bf7ff
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 m/pQW621eb8GNPti6Wasc64dl1Urcoo+g1vgjIADkt0X+mVgK+k8OYSWDDaBDw/y8dCk13b4eusQmXLWxCF7HCdRSo24w1R3wsdmm5L3v046f7NHsqeUoBJPEDHo/oQot4QVcDko/cNjIGLBndzVFwHP2QePJHo0d7hZupESfoaZ9nwlBNsnKRtP5ZyzEXVpPucbvFf37oaiNNOcWSAu/en5wLKjBj0WKPJHVYLynb0usDOeLoFO1qjJmwskQbFCzJJDIGGz1EG4ZfeGXp96wye5PLDAbPm6ZNiubce52IkgE4LjDRY8fE9L5fqWxKEtpamJESurTzXT0z8bDAOFI2V6/F+8I5BgXCj1VAee+UMu+AFPx9z8xp0/sXgmLsf1oG52Urfi08bEqsbqFBa1gyL4r1uR7OOkbV3Ddkh6EwHeF7z9goyL21lcB9J+/gJJ+Ek4BLY5+bMFi5mdrht2jTAwFBAZ4uwQ2aKGCeN7WbgRcGTKoAMxJRaYIG7iUVEyZykGzbPAHT93qICZek9yjMPtxeKcRQhBfIbICb6U6kf2j9EV80neUM23zrbZQZrY+sj5wEfLeHLQduU9J3KaML629JQj/Lh2SwkR8Rm/haneT/bntyU9ubF6erWiSdoCJDS+yC3fGuVmfIikK41KJ4jMLAnGk30/wXCnrYpEW78=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82960400001)(82950400001)(38100700002)(36756003)(38350700005)(6512007)(7846003)(6506007)(6666004)(52116002)(478600001)(2616005)(6486002)(10290500003)(8936002)(66946007)(66556008)(66476007)(5660300002)(316002)(8676002)(26005)(4326008)(83380400001)(41300700001)(4744005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?cOB8uSkNnue0ShKJ70LfzIv2PW3o8UCW1RcDDc7Z75C3EhItqfOG0WAqxoaI?=
 =?us-ascii?Q?Zg1TTjsFmMtoKYJX9B2moOxG2H30vfTQ6Csln35dIkYF8uF0hE3/Whfhszsa?=
 =?us-ascii?Q?sM+USXx9lXJzsDf4b6NDUSGrxYSvCqOz0idQmxqpcwy92VN4NXTtm2zSTApM?=
 =?us-ascii?Q?5Gz1WRr1QCVCjhWd1HPbLhCpqIdaOiXEcxqi0R2WhTzth9KdTQsSJ9/bWDET?=
 =?us-ascii?Q?sJRwYh2u0aAN6VxObSq2ujIP42H/Qq9bQMmWgQvZdnV8vmWvYISCOFpCGYMa?=
 =?us-ascii?Q?25V3hba8wrPksidwxho0BHgOJ/8inD3QHC/j6HC/Qulq2piZbWS7hgHyAiNp?=
 =?us-ascii?Q?DhA8n5K/nEvE5LoU4f0m0ALJKsTyEpsrIgh1c7U6m7xHGwtAeeWPHioaNUhS?=
 =?us-ascii?Q?i0MN7LGBPXmGqxSJrjQIzq79AgB+cFrHNQW4y6txGrnMf/JuXDfULt5InIL4?=
 =?us-ascii?Q?kOk3oPevy2C7fqzqHiHz1I8g7bDFP4WUx6i6Dum5oYxRy5ij19CGAoCJagv5?=
 =?us-ascii?Q?DL9lS98gaCYgGjIUado7/R+Z/N1NesshgNEbtl4kw1GufH57kre2F9l+dwQX?=
 =?us-ascii?Q?H3AJN/3DnMLBy5hnztGXRvl4BeO659S4efMZgC50EWs7oyNBq9Svahmoe5gl?=
 =?us-ascii?Q?SBBM4Z7nKikbZ7AvLYVFs5CSflYpCmVNGbzfiIpYLdBn+fzMx/kObclfXjpv?=
 =?us-ascii?Q?6bJ3goTsN22ZiJOWMBVY7UEi/B9PSHCDXIv/gXJYRRsG23elw3CL3tcAwGu6?=
 =?us-ascii?Q?NCT+lZEUjBoLmWLwVusAc+y9im+F4l6RKhjjl8K2bmLocHi1QvUymfSt+p9O?=
 =?us-ascii?Q?5ZnqbTv85cQbPblC+BOpiPRpHgw8iqeKi/lny3Xmz6AaCEt20jQbF//lWQRz?=
 =?us-ascii?Q?tUhY2zIoN5ntr5FJEBGv/hynD1gm1bBI5nmCJd5ewwcamUvhArChSGyvdKLF?=
 =?us-ascii?Q?uuACeSBCYm8gLeAuaToHiKLtMdqe/awHDX3gsobWSWjgwXynJjG9fa2pI5cs?=
 =?us-ascii?Q?SCukqiolmrPdGZK3zO4Ywj4zfJlhQmldxLF4NPoXX51K2ruruZzgfHKi4Ibp?=
 =?us-ascii?Q?izVEPB/Fn3aimR1EBwtri583Xy/VcLtxBjDfer6i3tIaJEiBcaj8A5q7dLir?=
 =?us-ascii?Q?DJaitffRyxLBEsaClrvG+yxkz4plChCvH+6CpA4LABwFNjmi9OZ/fNDlBLmX?=
 =?us-ascii?Q?GggOudL+pyiPcIgddmRdIG2h6leYCOm+5y1XYjE3gdiuSpuks0VCxFKXFKlB?=
 =?us-ascii?Q?B/E3tSEQlmGZxDBlMU0NVCFkhqvojeKhRdbnnv1vcT6zvRa1AFGrcl1qER+a?=
 =?us-ascii?Q?7Uo0UL2dudFAwNYrVpz/l0rmX3rUf5F+bRxaAXbz9FWXS0yXgiByyzS8P9ea?=
 =?us-ascii?Q?R2qaVAZLNBTqOlS8+6ziN6WDAIhu4wrAMcXP1HveIkCB9AoQrWgs0yXNjCKI?=
 =?us-ascii?Q?pGgC83TJWGdYmJUFlmNjz3EjkiexZ00ZPzHPnmujrfNqg9eFbd8wLS7K0q/t?=
 =?us-ascii?Q?QiEVv3kGWMQ/Jc3xuZ21GDfR3U3RkEGHiUnd8uDBTIA+YS4gjUgBt9dd6CvM?=
 =?us-ascii?Q?x9Bab5jTJ2eLt7j5XtPDF1hWsy1pYgL30pRQrGHB?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be39402-4d78-4812-2a5f-08dbe91bf7ff
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 16:24:14.1236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6L0ArSoSYfs7b3ahlFVTV7IN4aorE+2GrHZY+wiktJiyLEuQ6QORUd+5REVSuHiy73H+vrgdV2MI9okKzZlSPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3893

There are some races between netvsc probe, set notifier, VF register,
and slave bit setting.
This patch set fixes them.

Haiyang Zhang (2):
  hv_netvsc: fix race of netvsc and VF register_netdevice
  hv_netvsc: Fix race of register_netdevice_notifier and VF register

Long Li (1):
  hv_netvsc: Mark VF as slave before exposing it to user-mode

 drivers/net/hyperv/netvsc_drv.c | 66 ++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 21 deletions(-)

-- 
2.34.1


