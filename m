Return-Path: <linux-hyperv+bounces-9764-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ITtLgbQw2nuuAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9764-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 13:07:34 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F7E324734
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 13:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A179301A41F
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 12:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03AC3D171A;
	Wed, 25 Mar 2026 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J7wS3kOI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E803D16E2;
	Wed, 25 Mar 2026 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440102; cv=fail; b=VNkXKaqM/bs+XVFtmeMMBvgQc/CvTgH5566DHwa/0sFsIt/JFpQs4CDqkRV66M3o1f4iGRvrgdiUgLWeZX2gnyOZ2Tkq4vXcuYz5f44PPdKTAC1eAshRCEMRwxnZPjXSX8Kf+TNamHDpPS78NgiXZkPOFIvUTeqi4LqH11detY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440102; c=relaxed/simple;
	bh=bD7/HF24zKgnTWfvev0x/cUoxzSw93efU3aTxhBBUVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XeRuj5iU9RPmx1jBpNNtJm5Xs7YOAH6KQjgWonTiycCKE+x6hlDiAd2Vf2QguBD6Y/xQrzJ9RSPn6yA+wNAT4mFv8pdO2VkHLmcMuqBhU68xRcGrBKZw+2uY9v+mGeV2M+3m7MU/NU1ODBnhPrvu5b0KvsLXWO3/4BhRvo5QR7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J7wS3kOI; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kttRFgI2/iylIRsj5YKB10FAyWAymytV5Lq2Au/ItdO/sXFz8Ow659hb8KKMq+gHsxYaakF/46S7IaN/3KDvO/5kyPTzlAx+JQRVhCIFRO+EFWxmXy9RjS3wr05ooQvgLdEBR4lyG9MItZZPiomX4sp+Da4DZigG6GfO9hBwczfJTuxw+hT/eW8FoNSc04UPMN2RL5jtEX1n1CkghV/zxGYua9ZHEN+wDhHz5jnQ2rSv06nT/DFcrzpeBzLagtSSqX5CO76TgT/myxzMgWrLYmxGpYppKg1WMhY+OxFuUoXZ9bRSenrtN9qBMyx3Gm8K63RDCZAAmQn+rTlDfNo1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXXBntpqyuvabK9QKfgQGbDJFMmQc0BuxpCyE+N0g9M=;
 b=LrQ3k0K7bQbLI7Ga/VdoS9zgSx0tF/y38T2czp4oQfSdl50dc1Bbj35Id8ErsxEFGUAZ3aUtRKGy9L/Nxq/IsFesr4kUloiYWhJXZYsDgHOKMM2QInNDDdK+6p9jWSbDIQkkyWgttVkLBz4Su06qJn45bnVYwqsss+NMRS2YRlijnuUpfw0AlXxrVnvqXuIw88tsNLBhvvKIDkjoT86Sv/CeS8mcfHZzA+C7tmoBHPPjiQE7do2lwMtrvDlPScc6taJeAgXUXVEjBF88cSgelNRuW276dFNy9exbssWFnhiV35VBQwVHomgtWnKX+lSIvBr09/gpjSSmQMYyMaiLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXXBntpqyuvabK9QKfgQGbDJFMmQc0BuxpCyE+N0g9M=;
 b=J7wS3kOIzOp/PM1Yoou83qDqv3RnBDES7+thUv0J/24R3LLR10nSMH9la88tBzqfn8aMvhoh/Fth2vqnZUhdNydapTA9hesLUSFZjoncUjWs+LE+FjJMnVVxBe/JkmMvL5F3lhA0Ak/TxLUmBgyeIP4gdk0Qvd4xkvBz5ZGktJwAIGEHKiVf169FqLaIHUUUk/A9EDg4vbRDMSWQCos9KeHmaaGo3qyNZr0cwK4vKIvQFTSPpC+EKroRKgLqr2bT8xNcbmAZs20jB2tNF4CP8lkGOjUHTfaAaMC/PGbNjAq1A7WayuEduk5jVOkpEpNgdWzWoNsOxmW9VzvUPlOZug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PAXPR04MB8989.eurprd04.prod.outlook.com (2603:10a6:102:20c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 12:01:36 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 12:01:36 +0000
Date: Wed, 25 Mar 2026 14:01:29 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMSCwqlyZXo=?= <eperezma@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-spi@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-arm-kernel@lists.infradead.org, Gui-Dong Han <hanguidong02@gmail.com>
Subject: Re: [PATCH 02/12] bus: fsl-mc: use generic driver_override
 infrastructure
Message-ID: <cvcetxkxjq2tz6n2vsofhyzove3qdi2e4r6rq6yxou3joejk2h@rmt5ygav7ssu>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-3-dakr@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324005919.2408620-3-dakr@kernel.org>
X-ClientProxiedBy: AM8P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::17) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PAXPR04MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 444f69f3-3f50-4dac-40a4-08de8a664393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|56012099003|7053199007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YauE1OL9qVz6Ghkd3J4iiweYC+KTDcwgtVBRc6SzyGeDcIvAqr9GqhVgU2IK4k2+zD1XxZPGsKYLsEqiaS8RfvJO+yGdO9WoswEWIvqsqEFASVmWheIaYF6Je+a++RK8CPtKoUmtGv0bPuHQKh69kpeVWHxQA8bfzVd9gd2G4mJHqF2R/yvxG+kaFflL98lVbOhBJZVh46//CdTR5tE+vo9FZKLdM/PRl0QIa3bNJbT1IaRCJM+wNaaqNBIzvTqtbT98uIsOogkVCldOOrVdOIf3BEt28eAOqFMZ+TV6ETNq7EP8+961S1GpXqtc3J70y71lXxATEDMw4M7LruoJUvQCiEtLcFoE1s1XQG91q/Nj6FXkloupIpOwpO473+cAm5hHdWM8Lk7DN4mhymvIm8xrXzQomkVk0NxAwKEqKbG1hLhuQNb9GFMLvFeZE7wHopHrdCggnTb1OInKne9bPE5qCv6pjzjBvuCNuCasTBGwOUxQunyzQ3hhubR4Y5OBTIbDBTi+2fWt6pSW58kN8BCEXnWy5UvBhChefiek3+SDDzHh8IC6jKp5Z97r8VmNAfpxZw2XP05S5Ns/ZXQeLnXH57l5nV+ceXhGsEnYLBhJBHqGuDr3dTgOpwloRdJVUaA27Kw+UJgstnRgDw4BljSRQ1rbyIFnP2TZ5QuxCAsf0Q+eVAioW0X7cYqdNsEmIbHoBc2xrdOVB3nvcWTPoD2bk6N4r430UGOrsCSf/nI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(56012099003)(7053199007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wCOZvBxNyCZSbHbedjI2V2n4mKP/k/5gUrgXOwWGXKwOn843BAEy0H3Lu4Jf?=
 =?us-ascii?Q?t44F1A4mUDlyXUpBILTQsalQEZqPTb+cgccdo7yvS+9mDAmiACTuVKmRxjl7?=
 =?us-ascii?Q?M9InKZa5Am5jYZR+Y6nl4ZdHDTt+hCMDHFlOxI8riOBJRZnOAJTz6yzIxFaW?=
 =?us-ascii?Q?NuMDAuy0o8Seeb2//8zVOsrPkVe3gADXMwB6++DuHMeIgAiNc+QyX8DkXR5q?=
 =?us-ascii?Q?aXO5ih1Tyr4trPF30eexsGtUxbZX/V34UnBKtUiXaYtMXX9HbRMMTpbk92Gt?=
 =?us-ascii?Q?W3VVjo6p1M/5FsoqIX6FIBBE04QhKDSZIjs2/bYt7tHIfc+gW/pXT3ErP3Pg?=
 =?us-ascii?Q?Qt23L/3abciooF+nRzpRJO+oiAGqlsGlj8DFB3f4iExSOluU3feBUrelvZWZ?=
 =?us-ascii?Q?FxSnZY09HaUgZUBPbbvoMIt3wbRpiW5bmvMMr940BU+Q3A16vVDypKtcz3NV?=
 =?us-ascii?Q?BU0Ai/kGVJmc8saIbewJrV7vIIOx9ablRosiAQQpIPpLGSNdnB/PM5htvMOd?=
 =?us-ascii?Q?tY3Cqz+BLDwhYnCGEBFjg52OnkE8ZrA8OpAQPUXis7s9E/fs7Es7xl2IyPKX?=
 =?us-ascii?Q?V7kOH3wgDFGeIdk7u4bQcFKCuIWl7nqfG/FWiXnb8NouOGV5DjHiFcog3DG9?=
 =?us-ascii?Q?D3NwL0JdIPZlmBs+gt4O4kPQNcuuailEOeHJZWjQjdbP3DajBo3zTqnqaA4O?=
 =?us-ascii?Q?gcbrXQjGO/JlVf7IAR7Xj9as5QqU/RiCVFD2Kf4P9AqJrbGbb7paHfrs+ghk?=
 =?us-ascii?Q?B5dSKXfEUK9B9FDjyJ93sA3zJphdWq8KRjLbs0MF24LtTWFyB/a1sPoQfaY7?=
 =?us-ascii?Q?1zjFk06ZXuV00pBCIc7/0lmVkFqzmc81hUg6Ezs4fYmUMbzjyImSJkNC/Sqs?=
 =?us-ascii?Q?WohdgnB6eAaLAyYHxSO9ChXnD2BFaDtkPBzhNiyCIoT78MxbQPbT2auRlzDC?=
 =?us-ascii?Q?v+jj3XxnIFr/JFs1Qcq8L6SZ4dYzvAQrfNQbx8aCfUpQhn/Hm0OoXMY1eXdQ?=
 =?us-ascii?Q?2YtNVHLe5xsnkRrmnSasZ/8Vhs0RclkimVYpMzvWd+2VhUKS1HNh+0PGXCLe?=
 =?us-ascii?Q?aW2prGUn9xxanWMbaMLFsxrRFF0jdUZNStlj455tQaK/4JyvBzmTFz+GYGv0?=
 =?us-ascii?Q?SKKHB5GUNuTYcMNxcbmcbn4DNkC2IyYPpM2R/Z6FTxYHx1MTZnpWN/WrIrst?=
 =?us-ascii?Q?hpTDu1KHxUK3hzNP1zioROI0d1O3u2bHMyK6Oe0dISAyEbs+/swDAEQuQSJM?=
 =?us-ascii?Q?oMJZ6UFrgjS3+94++VT/pbI7PFmWnZiEIOnCkYqGC9Ip6y6KIcMc6Na6G5+p?=
 =?us-ascii?Q?oK2MFDEYv0QtNh92FmTJn/Q3Laz5Qm7zQahprTiJbJYTHxmHwhwGruDzKrLx?=
 =?us-ascii?Q?Dtwe5YakcFHXbUyqLxoipZvV6ysWEsbAM2nO1VYpddukv9PWHPrxRQm8l5A7?=
 =?us-ascii?Q?0tyBj3eFzm9quJ+hx/7kBMUz87EFfDU0j82a8ylOOTuRtMqApXfhMjI7kEzB?=
 =?us-ascii?Q?u+H9bPwh+nLvLbW9uXZj5JjZaAy23me2qngR1rLKYU8CiT8GwTcSYRwWw54W?=
 =?us-ascii?Q?p+dVtKlYG+ALObSrmAromuRz7Yxo9Dhfv2pIVyJ46WHdX6+8yYfBZQijauNP?=
 =?us-ascii?Q?E+YNOs80TCBLXN3dW0tPjl711h0vaRrW5uqL5qfhEkGoQyn/iuS4IB//Jo1u?=
 =?us-ascii?Q?k6YfWxq4S/jk9UJRRJ2uNOSdmAu29mvcMsK+yqML/1LIa1SBVvmCnZM3ZcZp?=
 =?us-ascii?Q?GB9hLE4kFg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444f69f3-3f50-4dac-40a4-08de8a664393
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:01:36.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Chgczccg4htJAVG6e4L1PTVeI+yR3WIw7pB21S+3KjxkMI90qw6f2G+r96bnAJFWq8f6hC+FMUaXR7ipTyy5SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8989
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9764-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[49];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,linuxfoundation.org,kernel.org,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39F7E324734
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 01:59:06AM +0100, Danilo Krummrich wrote:
> When a driver is probed through __driver_attach(), the bus' match()
> callback is called without the device lock held, thus accessing the
> driver_override field without a lock, which can cause a UAF.
> 
> Fix this by using the driver-core driver_override infrastructure taking
> care of proper locking internally.
> 
> Note that calling match() from __driver_attach() without the device lock
> held is intentional. [1]
> 
> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/ [1]
> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220789
> Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in the mc-bus")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>


