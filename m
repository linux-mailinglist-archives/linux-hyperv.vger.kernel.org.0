Return-Path: <linux-hyperv+bounces-10427-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG2gORrp8GlObAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10427-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:06:34 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEEE489978
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C60431436B6
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CE83BC665;
	Tue, 28 Apr 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="frumTChf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7787D33E358;
	Tue, 28 Apr 2026 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393083; cv=fail; b=RDDDYRhGb1xkz7F+J6xYrkrkI0CwznkI/dULa2RKPtAmuaPO63sSvBhz3rmBqokrCDTsTKZnrhEYjIV/50cyr01Bklei7gxIw8OiT7gMMbKqJznJAuD6oSFQSkZY4EjoeUYWLkyiVQB/MSLKYgTsMAhHK/5QUUncSqCQAz3AL4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393083; c=relaxed/simple;
	bh=kBeoMo8kpUFtcwEzcuVm3DPwOGAhWoIjFFUuPC++jZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t2zGwDY6DXRBecW6BRVg7PrFJ2ZqXFRj6FQApjow5GIn6FpSiDa+FYjAN0m/tgOgV4WCZoH5Uq3k81/yw94TzpAkVW7Ln6gUHQVPvysroju6WOjzgHUIRlLtHwbh+M+B0vqvz3yQGMFTqmzfL+wJaathqIwY7Mxtcq7oxHk6CvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=frumTChf; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTBBInX7Ba6KpbV9M4XVC0Cf1DyiE4ww3ozVn//lkV0nCHTfKKMCYHV3Y/JhgHjXNtNpvnWoC9NgpyIPAiwHsHrw7b0dqbz8TYE7J8it+U5g8ZrPv0QZhGHRVjDojhEa0iOY0lqBuE5mBnrnelwXxnar/2SdUj00hEPjBkVqbi8MRI2pHil++IgGObtRsmryeMDeOA6I5H0XvDxzxdoE6nQNeMg+XFhbhOjwEIgDzx20lnln9QMBy9QKYtOMR0sdLbnb8EnDBV2AId6VejTrsq53upPbkbV/yQ+tlOIwnJ1xxncxf2pn9tEgUzJ5x9xtD/QqRLo/qW4aiecM8t6WHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j6RxooUIs9ajYmdlLTeaEEhEibB3KMlNhyGUSSLh8Y=;
 b=CZcEcVRq185BPYv5tUXqjlH1ytGvL6vA9fC/1ZQgvKy6aUARtg3W+0aZ1pL+LfRGBlK/7+HvNfRYOcGDLXdGDGNACFzo6g08mgAlHkwDdFDI4iEZxuNsQHmw25bQhIJ0NJ5fiRWCTDw1FMhTWYh69o+0313axHkIxaUuNaXuhOWly0DM6Suh7LGC37z6NaHTIQEWYOkj5dEVrE1/9vO6vO9VbXWgCbUNN8e7DJu6rmyxFtfptA2gzPEGShP+JDYfKIKf+bfzk+RxIY4OfdQSpGgLMM7jJsPTI8IgNOK5PceNbnRpjuor8AGjaQ73GZh04hXB7vZIQzbyRL6SIEM2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j6RxooUIs9ajYmdlLTeaEEhEibB3KMlNhyGUSSLh8Y=;
 b=frumTChfPaWRSr2fvbG8XWVoNCWg56S1FyS2cELPEz+KqDWfmu2S3+NAaecaHTEXWxzS1DxLrYripyiHmyPzF8Nd+zXSua/4sESQPSm2EpVrqhsRs//QsVNaqita9bkIQzCj5pmV0H6dJZZkVC/65rhQIg+ofSFGjWTi2AoLS2J1uoPkVY/MA/OR/u+jEhZ9oI0pVdGBnd9mBO/6uBnrQlZg3wpDx218pQnEmyhGf1WDBGXrzHihYBZwgtMVQnbsvDBW57ZVnG6oFfNKtNsnGmo9Vv8znBegspzaq0BRU+a0E83lYV+DlsrFDSlSldsdBOFvU6Vrz7EKKHsAIaQk+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:17:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:17:54 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Eric Dumazet <edumazet@google.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Adit Ranadive <aditr@vmware.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Andrew Boyer <andrew.boyer@amd.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Brad Spengler <brad.spengler@opensrcsec.com>,
	Bryan Tan <bryantan@vmware.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Kai Aizen <kai.aizen.dev@gmail.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Yixian Liu <liuyixian@huawei.com>,
	Long Li <longli@microsoft.com>,
	Lijun Ou <oulijun@huawei.com>,
	Parav Pandit <parav.pandit@emulex.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	stable@vger.kernel.org,
	Tariq Toukan <tariqt@mellanox.com>,
	"Wei Hu (Xavier)" <xavier.huwei@huawei.com>,
	Shaobo Xu <xushaobo2@huawei.com>,
	Nenglong Zhao <zhaonenglong@hisilicon.com>
Subject: [PATCH rc 08/15] RDMA/ocrdma: Clarify the mm_head searching
Date: Tue, 28 Apr 2026 13:17:41 -0300
Message-ID: <8-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4c2df4-3752-40e0-268c-08dea541b240
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	oCUjAtVauQJC1v7QDkTMfK8b4xFHOREI3ItWsu102sPwp9OnaMGzm0sCwqiywmGIpHo7TygSTFly8TFEQUC/THOkgP1mtg0/hEZKcd3LKgYspYYIqVBy/YSbwhhG7PIzCSDxlG9rjzU91qWTWjViYqU8jnW+RCRCv6UM2rCa6V1j6k4t+Z+uZpQlrZ9vn0d6uZ4jUuyrP0+zMZZaH2ieUKZHlB2ZYjYpEERZR8MDMnZAlX8cMVIbPjCLsoJ8+Oj/rB/+hhwlzd24G4fcPwsG8TQYgtgaqHyrQksd51UcdF5tn2Kl4dCWkzuPRIS7Sc036Ca4HiFq3dCQtiiCgz9r79R+RgKN3WAEv+Jdf4EwOvVSEFeYeTti6TebFXyQbKGnDxHTA+Zw/Yz0sdoTbFrgiwx44h8WX44ABPXmDrFffueoArO8Q+EXsH06K7dl2tswFwtOs4eVhnw/eY2XqTU3qHw67uBFXIRguh5tx9QnuBP9ktDL/rE4FogB2ijLtGQ1VtuF9mgOCHcO3//jVMOo9Id5s9V/ppRkb2UaBvovFsVKiDE3Jn6I7DiF5l+8mkraBwm8pCGcaI2ecXP/O0zDLXoFtnl4vR6yw4NIN1gh05r4xhV1bvKYFiO++LuylYNU7+IX1nZuUh0tKZ8aTanLVJkP0HtXfy5ZI7EVqJrdju4mzBtRDjw6BwsFPbQLnI0v2agdKsIZDnjo9bf5luQZF51BZ8aMeEHal3Rwfm0Ai3rh0JcqIywOtTKjN3nWZOGWAQ/vIKvzzk+uU8fsnGdWVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Off3MeY3tkgklCUHn3tmdtvBlapQUsJ3KAPeuWXSusV6WiFA0SRIHMduJE+v?=
 =?us-ascii?Q?WnXv+cPo6wiz27Sp2T2vIKny0ALaKJLA0x+EJvTAzAhQ25eu7CMtOxqE5wrC?=
 =?us-ascii?Q?p48WC/53Uk0EW2tJrlFiSj/hNb1UUPi3wdt/GbRdwecYHVWB7v9C2ZtxHwZo?=
 =?us-ascii?Q?uca/CFTuINq4d+cJzDLgLQYDML3bmORJggn25EJ1Zhzgi8tvnZoG5YNHXu0l?=
 =?us-ascii?Q?Fs5VTQdAS1oaEfoMr8i0rdHypxvX/HR44N0LYXo/RO37PCIOZFfTdLz/ewNo?=
 =?us-ascii?Q?97taIJC4FDExoOzRnq4tRl+2HBZp8lPWxEeM+ZmDM9DnZIeiYww6QSLeVioA?=
 =?us-ascii?Q?zKBIQI8UWq+eVYnNwbQ/ZRONgLUXmEIChG8wseTH7wGPVVMpF5JDHka+9U7M?=
 =?us-ascii?Q?/1LMuqdGsH4sGVy64AnLetolTm9k59wBkWYah5Kg7suEa562fNwUw8Iqpits?=
 =?us-ascii?Q?8aLhwNTzMfHdjT4bhRGcVEicXk2E5MpThEXBKEts8DEVQ6Sg3aSCJoXrkS21?=
 =?us-ascii?Q?S5seqFpl9OIBkfytMVsq7LopS0UKo9EyXApDUQ0FSeEXttm/WVJOFtL3DWvR?=
 =?us-ascii?Q?LDYRCDgF6FC77fCJ7TVSlubD3xc3CRyg3dAQTRbrTLvBzqDdWD8Yc/4PmT/h?=
 =?us-ascii?Q?ZbW4AdLCIWnsTzlIuX2xK3VHM2DUjGOIKF5Wa4hg5BaHUwvW43+AD6Il74L8?=
 =?us-ascii?Q?lDCBdZNd6sL1K25Cya3jofeOoR3RQE4qh1Fmgafo/hvg0oYrwD+K/ZUohgK7?=
 =?us-ascii?Q?32S+Wu4mfbOr6pNMUI41QkHpvlb1IJmaCcwpQR4M0TlwgwPKUlyjsjuSVl9m?=
 =?us-ascii?Q?4zHhJrRaEUIT18V32YOu2YUWNl8UtpWUolpZNY/JhFlHHz/bvQxFTU0EWnP+?=
 =?us-ascii?Q?qDIVRXGWRgMiiUEqnxWG4+4pDSkbML7VJyyIHR8wAgSQQZLyRMxauh5juXF3?=
 =?us-ascii?Q?vpfAHy7bJ2GKg5e5vTLSk7G1ZTDAB6FyRJ5iceQU/eo7ZCwaZjJGrOvfvq8U?=
 =?us-ascii?Q?eo7YuUrmRVSFUPayfllLH/e0LuxiMes82qEDmstAKY7NAsOCPdLos+TZUh7J?=
 =?us-ascii?Q?BWSx4zNRvfykJ2FEP4UGDPneewKpjPKDayHmmPnV1nfJJ4VmorFnag4uZP2O?=
 =?us-ascii?Q?U6m6Lt4f/bEDTtvtVlfalYNkKBbQ0wT6WEmwyO1GNL1E/cpNuSh3jAAgrJlQ?=
 =?us-ascii?Q?rUp8fF3vDiySlWVCUiMGudWrbpi670xQvZBCmTXyCU/p13fTZVrLdk7k0qyN?=
 =?us-ascii?Q?t27TWnXHes/JR1pPKPov6akyvYjy/rP4BYzpdcSWPw0UOEUpo8H7yZuMXgYG?=
 =?us-ascii?Q?elf2f17AxD1e1CYQAA6obFQ86Ej5CcH8Y2kmRPY78lltP+i4/PqvueLR2h2R?=
 =?us-ascii?Q?fMD19LCRZybFQKUwjanJnH4ClP6itNg4lQ4yh3oXYkzHdkQQDEfsu+alcg97?=
 =?us-ascii?Q?P5t3YItv1LlG/R+aZvrMYe+PGfu05V/Z+KCkGSu79mMuiReca9SeKPKIT8gD?=
 =?us-ascii?Q?0PKrbMmw1lr7dRgjA2W8FdQRLi0mDuv0Q6k0j0OlyRzbv4AfPR8a0/4gp+W6?=
 =?us-ascii?Q?hOpqChYN7I5fCTlKqNE7l1Eef6JcpSD30RkFnHJjwZOB46sEcomGZpa/NjtB?=
 =?us-ascii?Q?5eO9f9vAKzW/PupvSl1UBIlonSYm4CT7FT8XMirDfMpqq1lJ6N4jaf+rzA7a?=
 =?us-ascii?Q?048d61tHI+2OCDmW59f0tmsgoOuEofaLqZAUH4PZEmXicMdj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4c2df4-3752-40e0-268c-08dea541b240
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:51.7802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fl7QXSRwd2Zq9Um9yg4pXzFmwPF95yc4ZRijepCFhOSvqXdjIU1BnwZL1aFuugUy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
X-Rspamd-Queue-Id: EAEEE489978
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10427-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]

The intention of this code is to find matching entries exactly, the driver
never creates phys_addr's with different lens so the current expression is
not a bug, but it doesn't make sense and confuses review tooling.

Search for exact match instead.

Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=4
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index c17e2a54dbcaf9..463c9a5703fc4e 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -215,7 +215,7 @@ static void ocrdma_del_mmap(struct ocrdma_ucontext *uctx, u64 phy_addr,
 
 	mutex_lock(&uctx->mm_list_lock);
 	list_for_each_entry_safe(mm, tmp, &uctx->mm_head, entry) {
-		if (len != mm->key.len && phy_addr != mm->key.phy_addr)
+		if (len != mm->key.len || phy_addr != mm->key.phy_addr)
 			continue;
 
 		list_del(&mm->entry);
@@ -233,7 +233,7 @@ static bool ocrdma_search_mmap(struct ocrdma_ucontext *uctx, u64 phy_addr,
 
 	mutex_lock(&uctx->mm_list_lock);
 	list_for_each_entry(mm, &uctx->mm_head, entry) {
-		if (len != mm->key.len && phy_addr != mm->key.phy_addr)
+		if (len != mm->key.len || phy_addr != mm->key.phy_addr)
 			continue;
 
 		found = true;
-- 
2.43.0


