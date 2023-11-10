Return-Path: <linux-hyperv+bounces-839-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32C17E7D0D
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A48228112E
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8C018E04;
	Fri, 10 Nov 2023 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="a+FdyGum"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7DD19440;
	Fri, 10 Nov 2023 14:39:23 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020003.outbound.protection.outlook.com [52.101.56.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2EE39758;
	Fri, 10 Nov 2023 06:39:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYB8tOyhjtUWZ9LC+Ass7I4pw1bOtbMMsM8VUnjkV/a7U4yMvSX0O/2OwYViuqAYIBpm3H4nl/hwNZOnBAyQU1tjq7P1/Giy9+81NbhFeh7abGAXkjCeTFAe906WW1rdOy+lC3/kNDPa2AP2y3fSx2n/EuZHCXUYWzPwnxC8dxTtlPjPEC3P02OlLxlkDGiL96AmxuoHUnYDjmZEaFQNe0zVWr/8Q+2yVMyM+WkjhcoSDFYSM+W+8W8pitHsHJfDFvdvPT0OJhFVXOCyO9uVCfIAQUtDSaGekUtwH7iFEg7cl9u3ITRszNTJlI2lOslLn0vPO+oIQRL+zqZQ1r7Esg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvG8FWJsahe75UWdkc8H/SWCklB1gABxa1+iAA9OOIs=;
 b=FKSa1PSibB8ra7vbhoOS41mSs5Y1l6tZIsiOSISJhbS9QMFKdVcyT9WFJK0crHPLXUXmc0xzS9dbjNec/ApKltBiew0LHNe7oDCUSyq/10TX2FJrccoc8TUBmmCaOArXlwetIrRxJu3nFKGNByLSADqt4Xo7dyvGcB7hONnK8BSghpIKHjwcNS2m09EZ84Pkyg6FmphoGmRT/X3KnteR5DpklLp65vnrD4X+osyiFH+PVAE+ymSb8SFfo2gct1xE4Xcj69CXyHB1+CJwms1tIE1cDwGEe4Ep9zHyJj8zLwOm62Dy5w3VObAZqDhJ/PCFW0c0wqxi9B30KJfW9KaTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvG8FWJsahe75UWdkc8H/SWCklB1gABxa1+iAA9OOIs=;
 b=a+FdyGum+DbnztgZEXE8sD7IH+h9Kn+ylExiwD2cMnBbuzX0qaTT9k+abdw6GIZmCunB79f9FyO1dJl8c7b/a4evyTWedlDYxj8hHbZOaQyUWcrIoMexuBnguWU7/HVe4cSK7cbyLyjXCB+s7lbKFzePY+RmAL+Mwly+aVPzmuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by BL0PR2101MB1348.namprd21.prod.outlook.com (2603:10b6:208:92::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.10; Fri, 10 Nov
 2023 14:39:19 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2f77:8844:9c3f:58c8]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2f77:8844:9c3f:58c8%4]) with mapi id 15.20.7002.008; Fri, 10 Nov 2023
 14:39:19 +0000
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
	davem@davemloft.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net,v4, 0/3] hv_netvsc: fix race of netvsc, VF register, and slave bit
Date: Fri, 10 Nov 2023 06:38:57 -0800
Message-Id: <1699627140-28003-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:303:6a::27) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|BL0PR2101MB1348:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d41b32a-ef36-4f0e-c9ed-08dbe1fad15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/nEuBF97SU+pYiJFKKLPx5D/6kLAFPSZnW0IbSOSeRN/9QSalsX9NaXGCTN7v+eR8oOJTg7JOQMoG/9aAKRa/rNW4bOUWA2v9OiDt+cFAG64Lyah6Go0hx0Ik8QHG5/jrzHyjBHVFgHEGS+8N7O10qmVpRKb2D3ELqtZdTrKpdgGDr3HCdoHNwWdfmeZnJWYJ5WHwb5NR7Gxs9+sI9Lxz68A5fkmhJnYdffTxE9TSO8QL2dcBLR7KM35bJq5bDOHK22MnCKh2lqNoX1WyCmNk1GeaWz7FvKnyayeZUFknivHLSBPOvbQC9xrx9Kz//PttuRIcp9PrxvzQzLMaD+cdAeo81s76mJ8OELu6E9yQRQivbmdUbuqEXPMu8q4Xa27s8P/Lh6YPye2OZD0UuKoouJcBq5+41OQW7UKqmRqGaXPj3PhbN1W2oQFck5G94nbeNem4s5/ueEvzFKxsd1IptGgNbY2YQanLOxfNABNVVdkjQ4ARxZJZYjbF///eYAgpHgN/bQ8A6/J7yvRhj6DcwUT4fU6BJZLI2ZjNijXmPRZSgoEgI9a3TdXOLDFCFReB3ElZ8NnRKJxl8w5KtpW+Sl5uSizcLyQkXVZHS7eWzv35mBEJb+YGS7KNcKZzXXMqh1Lfk9BHaE3JwRgad8d8qpoSBVuQf8Ra2zQvAJpWv4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(83380400001)(4326008)(38350700005)(2616005)(82960400001)(26005)(66946007)(316002)(4744005)(66476007)(66556008)(41300700001)(2906002)(8676002)(8936002)(5660300002)(6666004)(6506007)(7846003)(52116002)(36756003)(6512007)(10290500003)(478600001)(6486002)(82950400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BLZ7zf4tUFe8eEIsI2jgqvBPzh0Ka7IXJaXYeqp/rOdI3l5+rSlIySm8rS2Y?=
 =?us-ascii?Q?XVzNHRU0PGPZiVy6UG83u0h1KIaXDpVcCvrdIikinF4V5h2leUOJA8r4Bp+P?=
 =?us-ascii?Q?MCa0OZGzxQynurH02o1RVVdvc5XHi60PQTaJunVhJ+urC5SqI160oFVlxCsW?=
 =?us-ascii?Q?B/yVuZbA8CjkcHroBQFifIHr/bfbDUN9zcH4ZDcNAG9PsP6e/hZnzWGJ60L0?=
 =?us-ascii?Q?OuaxvAyjFQnixbwfxeqVYjNh1rPHIjl3YjGS+2A/gKN8fnnaVp7KpOJ+k1nK?=
 =?us-ascii?Q?ghjx8zmzpFvUIS7lL6BcIXnCoEkcy+zm+TgJ7sY4ttvCtwpZSTJg0mQOdpOp?=
 =?us-ascii?Q?2fvv769ALkC5QlDMiY6+FJReKd3fCxrZ5OMButbai/0GfRvEPeoyany0oN5D?=
 =?us-ascii?Q?DLp0DGiNENacB4bqU3tvuLjdiHuu/fDTjU2OltmX5XdNR4mFp0zqgaTYag6x?=
 =?us-ascii?Q?CqForWcH7xcqHjXFLNwwAuv2LKymTa7zUrtSGZoW14cjRUQO3KoetnDocZXf?=
 =?us-ascii?Q?fCnDundUc0D1m4PI5AE8Mh/9lgki+FNJkr398OT9RjnDID0V+VIktWmQJa7z?=
 =?us-ascii?Q?0kXqmlQDJxQ59EYg3uXJmcp0xVghDVBG2BN0V+e8EI3d7vZBetlU/DpStoPC?=
 =?us-ascii?Q?/EbDHi4nSNhfdvfK9HVetU6Ae/2FHia+VW/8aRrZN22T274lf5H0Jnck8ZPR?=
 =?us-ascii?Q?8xkdKQMxM7TnwaConiOgA/+bjvrZBaHMVOJf7Txxp6WdMq5d9bZsk9t8Kdjc?=
 =?us-ascii?Q?4OUCE/U26SDGDro3jqbu1OpJNlHnZRjWe1VB4PPjGww3yANpy7zcKzYq1bnZ?=
 =?us-ascii?Q?ToWn7jiDjtYoGEh79XhjmTnm/g4vQEaQgC2zNR/83t+9lw5+MSd10FEkr+vV?=
 =?us-ascii?Q?V+cO40ZezzfhH36eIt/yKpa5mSUSw0TrQtvUe5a4TbSR15h5+hklzFqSyHiQ?=
 =?us-ascii?Q?N2935TvlA/MAQh4OxO9c7U8nWCCzlxfeUdtyqc4CxXJUZ9UhXoE0BNSxGX++?=
 =?us-ascii?Q?wrcZpZbKJuZ6TTIAvZ4awfMqqxoAZRgp+Ut8H+NhYW2bxXQ/t/3gz5mF+D29?=
 =?us-ascii?Q?kMv1pH0yWdCWNiGWM2UG3LJfkkaV7E/svzHLvh/mc5kbsie1/vAkQ12Dm5nW?=
 =?us-ascii?Q?KsPPkHNBYktPb/CjC7X/5InfRm+NukQzfyb9cd5YQQDvj+SnYcq+Aenfk7u0?=
 =?us-ascii?Q?8E8MXcuQBStydLH66KP5NNK2rT9I9QSesITOExKPFMyIc+g710wvuwjcj4h8?=
 =?us-ascii?Q?DNi+D8lgPE3Jy64JEhR79FbLTBvJ0zd5lpb0Z6+R9CSN6PhJri43tofvk+Zg?=
 =?us-ascii?Q?x7jDpoXwU90Mci+PL6DJZ7svCt/NtYyEsJtXznkKk60G9OVOF3U0dLogqeLM?=
 =?us-ascii?Q?8IuErsVgTDwaFbrdxyr2i3CgeQ3yJ9L00iwy68kD4RcpJgMYPxfwXp0GGh6F?=
 =?us-ascii?Q?fbXmkE+HjTq8p24pNBx+dORAqwrViwEZ0teA5+JH48TYmR7vg0i3ZRT7M300?=
 =?us-ascii?Q?AEATDKtA13aJD6SDruwudxm7IrD6dKM1uMHIvQhWg0AfMsrvHBwBJbcZRYpy?=
 =?us-ascii?Q?2wxaXCi4swp0Nk7jcw0/LL9+fmxdBCY8Zh4eDIe7?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d41b32a-ef36-4f0e-c9ed-08dbe1fad15e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 14:39:18.7133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXp1WLSutcTner2DcfpfXRbQLtIqyHiZrtvNg02h5sy9PoLnuCwFGFAKN5qRXh1vMDdbkKcR1qTR3LDClgQLuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1348

There are some races between netvsc probe, set notifier, VF register,
and slave bit setting.
This patch set fixes them.


Haiyang Zhang (2):
  hv_netvsc: fix race of netvsc and VF register_netdevice
  hv_netvsc: Fix race of register_netdevice_notifier and VF register

Long Li (1):
  hv_netvsc: Mark VF as slave before exposing it to user-mode

 drivers/net/hyperv/netvsc_drv.c | 64 ++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 21 deletions(-)

-- 
2.25.1


