Return-Path: <linux-hyperv+bounces-8975-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKoTCo0nnmn5TgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8975-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 23:34:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8780318D648
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 23:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7325308ADE7
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 22:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8643A33065B;
	Tue, 24 Feb 2026 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D/ZacRf/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021073.outbound.protection.outlook.com [52.101.52.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EDC1B4F09;
	Tue, 24 Feb 2026 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972244; cv=fail; b=jlVrIh+/pSkPijb/qxOOLESLv+YUD01sHVdZ8UskZ6nq4DzOwmAnRCPNSdLf7JMjfdRIbWO+Qo4GxeJXfKdYYOhRxUVX0yCUpmaZbg6sLCxe27jaNljFWADaA5XTiBDNlZO11JcsqPYClCVTOmBq+Xof+pBHqXoE7dzyAtCFsYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972244; c=relaxed/simple;
	bh=8ATYCq8+Gosq6oet2JfoGCCCnkmVpUulUvZWkTAAT+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i3LylyZqUhC1x8rrc1HaoW6L0G2N1VAOU07WEUzp2a/Cd/kAly9jybQoeFJlV4+gmu3VCalrjW/oT3xGoxywlFphPsG69zr28Kjwb8Zi02+E+rwv4W8ZzsUsg3Jmy83fbpFjIgrQ1e2f8UQDOUUFtDy1pn3QPsLQs4FagCJFi80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=D/ZacRf/; arc=fail smtp.client-ip=52.101.52.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8b3h5ramXA5ppZ4s3pWxFj6fi+Xi4GCLGvZn+bdDjntFzF+kgITS0mKSr90GzxgUNyfX71slFdpfCfH0xL8g4psdLqUEyALNxUMmRAlu7CVlAue5sFYXq2SoBmoZN0h2hVDjqUWYe8mZnUSWIiz2RW1Cg1cHER8yQrqftvHL6Yc4MBoijJreeO6JNqjLUA4Sx80IFEtnJd5/tP6Ph7z7HI1sHBw9e3kJ0GiRXwEZlD3AvkbsYdZ/5f7QbRXho9Y20nphB/vQSGo3u3fdyI1DerBMwBWzWdwrSZbcQcK7tc6FWTzg8Og29S6XGWfQ8kaZrmf9v8H6h+C4a2qiTZ6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ATYCq8+Gosq6oet2JfoGCCCnkmVpUulUvZWkTAAT+w=;
 b=OuxId16yOR9jj3axj4rtjGBLsl9Eomk3CHgxaXSqsna7B1dfQUW3/1JfP2oqmGe5TMw+FvF4mV98ZPuWQUPsxazKMQ2rBrNQArExJBzEHjc83D+jJxS0FEdPysCpuJL1adUoOvvLdTVcI8hS3Chbk6v8pbwXIPO4f6XPXHwN2PQ9bB0RJ65V5eeXNiDwJlToPE80hm84BqDJf03TkGBCIVIxI8QhuoI1OzPahNhwFZn5EMsjVXbvHlrBp21Fy+npF33o3dZiNdZ+A7rcGloeHVgupC6icxbxmy3BIDVJSpkY/Oq+m7Z7Y1r+kiPaA+54UEPIe32eOUftS/nAQIs/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ATYCq8+Gosq6oet2JfoGCCCnkmVpUulUvZWkTAAT+w=;
 b=D/ZacRf/tlWLy7DnKdrA93/kPuyCpeGJM2D4Q6sgPDiQlNaQqpSC6GlX+HQn2ldhc1cKAs8zt7t5XW8rPK4+Cgr9KMY+9ArlMAaDYgVR2/AwGOwWp6/ggkEyYs3L263+kspLyPhwQpDbFm4ro37Euz40gv97JumMDyh8TJiLFsM=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS2PR21MB4725.namprd21.prod.outlook.com (2603:10b6:8:2af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.7; Tue, 24 Feb
 2026 22:30:37 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%5]) with mapi id 15.20.9654.007; Tue, 24 Feb 2026
 22:30:37 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Selvin
 Xavier <selvin.xavier@broadcom.com>, Kalesh AP
	<kalesh-anakkur.purayil@broadcom.com>, Potnuri Bharat Teja
	<bharat@chelsio.com>, Michael Margolin <mrgolin@amazon.com>, Gal Pressman
	<gal.pressman@linux.dev>, Yossi Leybovich <sleybo@amazon.com>, Cheng Xu
	<chengyou@linux.alibaba.com>, Kai Shen <kaishen@linux.alibaba.com>,
	Chengchang Tang <tangchengchang@huawei.com>, Junxian Huang
	<huangjunxian6@hisilicon.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>, Krzysztof Czurylo
	<krzysztof.czurylo@intel.com>, Tatyana Nikolova
	<tatyana.e.nikolova@intel.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	Yishai Hadas <yishaih@nvidia.com>, Michal Kalderon <mkalderon@marvell.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa
	<vishnu.dasa@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Christian Benvenuti
	<benve@cisco.com>, Nelson Escobar <neescoba@cisco.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Bernard Metzler
	<bernard.metzler@linux.dev>, Zhu Yanjun <zyjzyj2000@gmail.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH rdma-next 25/50] RDMA/mana: Provide a modern CQ
 creation interface
Thread-Topic: [EXTERNAL] [PATCH rdma-next 25/50] RDMA/mana: Provide a modern
 CQ creation interface
Thread-Index: AQHcnNf52lQ4rTSUQUK5B7LHpURRkbWSepog
Date: Tue, 24 Feb 2026 22:30:37 +0000
Message-ID:
 <DS3PR21MB5735C22704C2AA25C5037EA5CE74A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-25-f3be85847922@nvidia.com>
In-Reply-To: <20260213-refactor-umem-v1-25-f3be85847922@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=24764cf8-7bf6-41c3-a72f-771057ec42f8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-24T22:08:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS2PR21MB4725:EE_
x-ms-office365-filtering-correlation-id: c16c96a2-8796-4493-df66-08de73f45578
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWx0b0gxVy9pcnF5S0lRdWQzVzlaVzhEcTJybEhtUVR1VDBTY0tPWFF2RVk2?=
 =?utf-8?B?bmFiMG8zTU9KQnlhQmpCb2UvOXF5ajl6a3hDbi9JVXJZOFpFL2VpbW93eDI1?=
 =?utf-8?B?S1NEMzhXVmNYaW4rM2dxNVhvQWdURXJ2THZtS3VFM2FGdXNPV3dUb3FjUzky?=
 =?utf-8?B?WWdFWUZ5MS9YZWFCc3pMMWJyMUs4T0ovclluaFRYb2E3d0tNUW5EQTNFSEEv?=
 =?utf-8?B?L0pZdTg2dDNwRlJVeXp1a2MwN25nTk5VMDNTZVBJUmV0NE1Ddml2alF3SCtu?=
 =?utf-8?B?Z05KNFJibmpwQnF6RFY3UE56TmZpbThqUnRYVFZaNWc1OGZ1TmptRWxPTlFH?=
 =?utf-8?B?UHVVbjZFTDk4cDRrdisrRjdET3JRS0hkYXY3cFRRVm5wUXEzYjByWXowRzF4?=
 =?utf-8?B?WXRIYkFhVWd1bTVnSHhLWEk1eHpJVlp4NEFMVXczVmUyVXhhdi81UmFhdEdY?=
 =?utf-8?B?VzVSV0d1eVVWN2xERWpHb05OeTZweXVYck5jM3JYZDB6ckpwV0pHeDF1U0Vv?=
 =?utf-8?B?Q2RtQkttTC90R0hCdWtpYVVNZE1icUQ2N2RyQmpPK3FoSXFUMWZvL1VCbEow?=
 =?utf-8?B?ejlBcDFFczJQdmJtTHV2VWQwMFVjUkNFZXo1WXhaMWJjYXFLSE90UStROFR5?=
 =?utf-8?B?di92eUN1WS9BMk9FZVF4am1Ba2FBSVMzVlhmQnJzMWRkVFdtSWdIK3ZzaW93?=
 =?utf-8?B?REJUaFdtNG95VGxFRnRJOXJIbWIxcGdCZnB3WHp2MjFxTGcweGRCWC9ja29Y?=
 =?utf-8?B?UnltY3BXRXVzeEJXdjZMWEFWOTFia1VpeXltb0E0MWxXN3YraldlWU1mbkVj?=
 =?utf-8?B?WldsdGxFM0Z1L0NEckFxUlVrZnhoaEVTRmV0dWR5Ym5vbFI0c1kybzhBbmdK?=
 =?utf-8?B?b1BPRW5DWnNpa1JRZGZOQnpDQ3AxSW5QVHFPcmlTSkRUT1ZhREdMZG9CV0lT?=
 =?utf-8?B?ZS9iZVNjd0lKcjVvcnV2d2hvZjc3NFRlOWFZa3pZNmg3MUxrc0I0NENTMXRI?=
 =?utf-8?B?blpGK3JpQ1ZVMm1xUVlCN2c1UnpobGxGY2dRb0o1YjhMLzUveHQzbkR5UGlW?=
 =?utf-8?B?dFpHRDBSMlhJN0tCTWhXeVhLNkRDaytqd2ZrWkZ3aTV4cFN6Mi9jejZ1aDF4?=
 =?utf-8?B?R05CMmxiZWtkWXlza1p5NStYUDhMZk9vWVNlWEdRdlJGbFUrYkU5N1RrejZN?=
 =?utf-8?B?dkwyZi9ZZzVLWGdDdkEzNXpvQVpDczJRSkN1WVRzYWUxK2w4NTJyVHBLOFhY?=
 =?utf-8?B?R0V0MlZKWjg3Nlh2RkdPWWJJYngrQlpjb2V1SzF6MUx3cHFwcTlxRUw2aUw4?=
 =?utf-8?B?MndESTBuSFBRaDIwVU9OWW1Wd2VteVpKVGxMY3lBSnVtb09jMSt2anROL0p5?=
 =?utf-8?B?YjNjSUovS3BERFlrRjFyQXpIRWhmVHNpVkE4S3MzVysvbGRTUHVQeVQwKzFt?=
 =?utf-8?B?ZUE4QWZUdGNUYnVkNDZkeStyS1V3cVZwN2xwQmZxWkJJeG12K1JoS2xWSVV2?=
 =?utf-8?B?VTJWa0dnR1FnMTUvbVViNGFGVjFvY2pScWRyc0pqbmQvV2FHZWpuN0RQSzZN?=
 =?utf-8?B?ZlhyZWdIanppdkFTMkVNVHpiOHM4WEI3NDZ1QTk4bkp6S0xEOW0zZ2h5eVU1?=
 =?utf-8?B?aGZXdEpEZEd0TWpxSzRsSFFjR3RWRm9EZGQrcUxUNllibnVLNnhiYmRoK085?=
 =?utf-8?B?VjJLdkhuVGhpMk9oQ0ZqM2N5Q3kvcmpSQUhWU1dVQXV3NHRCMkk0RVR0THZt?=
 =?utf-8?B?U1l6OWVDTXNLWGp6Y2lpUm43NFN5ai83RGw1cDM1b0VFd1VNR3NZa1lqQ1Rm?=
 =?utf-8?B?V05seXhoTHJWYVpOV3FaTEhRS2dMblhha2xvUHpoc3BQN0hUQVNCSE1jcTNi?=
 =?utf-8?B?dlNrUm9HTHB1cjErN25pZG1nMWlWSHpwaHpvRktpT3ZrTFBmWHJHckFZbnV4?=
 =?utf-8?B?Z3dzbnI2VTg1Y0MwNE51N0VWSi9McllBclFlVXFraDYvNmpzaGZJbkx1Wjhn?=
 =?utf-8?B?Y2RpcDZOd1EzQ0h1Yk9ZTE42ZnJlcm9XVFdxclp0YWFqV3NkZjZ2eDNwT1V5?=
 =?utf-8?B?MTl1OThldDAyaERDVks4YzNlVGFJdE5JYnpjK3VjZEFoSWEzQlhDalZVZXl0?=
 =?utf-8?B?RzVoMzVHTUJ6STVwcE9Oc0N5OTUzaSs3QlUrQmpOcXBTb2hiNEUyUFlIcUh3?=
 =?utf-8?Q?fx7N4mhml4NR9ZdZY9FvPLF62DNYxkYqs/cPO5NJ0nPq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0VCaVJQUGFuSjJGRTk1bE8wNHdOY3pSRVBFWWRPVnA3Q2tLMlB3dVRhdGVL?=
 =?utf-8?B?QjBteXBmUFNhdFJjbWZIK2VkZTJ1TStrTG12Q1ltOE5XeCtFYUs2OWpsbXRG?=
 =?utf-8?B?QXdpOVc5TG9kb0dHL0prUEI1MVV5Q2w5UGI1dDBQUVVyWXErMVd5eXhXODd1?=
 =?utf-8?B?N0ovV0VaMHpZVDhEVjg0S2xXNmw3OFA2OUZNdUNxcHFHQ1BoUlFlcjlkcUhK?=
 =?utf-8?B?MzM2cTErL0Y1Vk5UTE9VTGJXcEVETkZTUGlTdnhyM052SzVwTzB4MkZ0d3Vz?=
 =?utf-8?B?Q29vQ0E4S3ZhdWlIZ1QybUFEMC9HdEpJMm5VRUVVSlBRMHBDVmRVUnM3T1N6?=
 =?utf-8?B?dEd6NFppc0c3T1l6N29kYjQ2R0RXMUF2akpBRnZMaFNZOFljc3BEZDNybEZY?=
 =?utf-8?B?VGFQWTJhOG1OWmJETDNaVEt3cWVDVXpWZFJXbUdsRkNjcWJ3UG1wM0xDclh5?=
 =?utf-8?B?NmtYRENHQzhBS2d0VXJIejFzdlBqOW9YR1Q2MVVzTWc4UTBZTGRQMTFNZFBM?=
 =?utf-8?B?Z3lRc2tOZWdTQXFvbVdIclNlNFpKdmRnNVdxNHJXL2xsaXZTSys0eFFHUHB4?=
 =?utf-8?B?YmVOOFBBUXdiRUFBbjZlLzFoM2w3cjU5NFNYc3crV1d5cG1ueUx0SEJVMlNI?=
 =?utf-8?B?WU5SSUhwUlFURUZXRk93SDgrUmxYZjVWSWdvSC9sZHNMemZlOXV3dGNCOVB2?=
 =?utf-8?B?T1k5WFdVN2lKZ21rYzZGVzhIdGpKcGl1K3U1MU1WUjB1MEkvdHhIY2hVSEJm?=
 =?utf-8?B?Smtjb2hDQkVkaEZtTGt6c2tpaXhPZkQ4WU9BRHBKSlE2cUR5SFUzL2ZwTXg5?=
 =?utf-8?B?WVZVZDc0TU8zY1NQU0c3SkVpYkwxRXFnUjh3Ry9jVmN2V0pzbkd1VmFsTlpC?=
 =?utf-8?B?VElqazRoU1lzUTFYcUNXTnUrRlhBbGoyNTduSU9EZ2tzTndoNHdnYzJwTExp?=
 =?utf-8?B?MXNGdHFkRVJPeGFjTkpTbGhUcDlnS2hxRU9FMUlmbXZXSjkxOHVxNHNqZWVh?=
 =?utf-8?B?V0R5N04zckwrR1JXSSttRTdVQ1VQMVg4SDdwTGdhYmN0SDJaNllEcHNZMXNF?=
 =?utf-8?B?YkhTeERuSFBjL0V4NDNWR2pobmdqWHZyZEJJWTFnUkpQUzdDRHpKMzZndkhC?=
 =?utf-8?B?T1NaL0dqNVkxbUFCaEw1K0szY2t5ZWg1Y0JzRTkzblY2TCtpbVVWNDZWQVBQ?=
 =?utf-8?B?RlZ4WWRrdjlXYzlLRitYRTVuUUtENDFsa2syZDk0am4wWWI4UnhtR1VjTlVn?=
 =?utf-8?B?cHlSSXVXc1M0NUhWN2ZmSEdQdmEwcDQrMDlzUERuMFoyTk52aXFDQmVrSXZT?=
 =?utf-8?B?YXJzSEI0WThsS3NVS2V6N3hmRHhzL0IwV1EybEZTYkZ2UXdObC9UQlJSeGJq?=
 =?utf-8?B?VDBIOFNXUmhqamM1aTNia1BrNjkrcGJROXJyVENKZktmemFnd0RzMkFvQTdQ?=
 =?utf-8?B?NGliUWVZUVNBWmtYdmdINitoejBlem83ZEl4bzJLNnRSUUVsay9aRytyZEFl?=
 =?utf-8?B?TGl0L0h0TWdGNmlVb2dUWWZWNVU4VmZkYjJQZGpYNGhmeTd3OFFNM2psTEk2?=
 =?utf-8?B?Zmx0aWhmcDAzWUhzbWFhZ1hsUERzMUx3VmkwZlp1dzZXU2xBN05UZzBpWThD?=
 =?utf-8?B?WDFPNzRyV0hSa21lZFkvekRwNmR5U0xUYVZjOXRNdUVtVFlsL1hiQ1ExNk5k?=
 =?utf-8?B?SDJtcDhUb0NsdlpXSktiRW8yVW9hTnZqNGZCeHk0VkphMHZ6VXBleHpKRHFa?=
 =?utf-8?B?UW42MVA0N1NrbDMvNEFmUVhRQVFkeXB4WjZwbi9ER2szU3laTWtWTHBaOTRh?=
 =?utf-8?B?dXVEWk55NjV1cUlTZnNzYVJHcGRwbXZaaGx6T1pmZmY1T3ZpQnhrMWhPa05S?=
 =?utf-8?B?WkZUb0pJV2QyeExRU3JpeDRoY2lLV3dSWGF4MXZxWklvRm1xZk1TenN0NzBI?=
 =?utf-8?B?bnZmWm1MSXhSUU5Qa3BaRkVFUjY5TE1GUWxnMzB4OGd5c1BxSHV4SnFhQTJ2?=
 =?utf-8?B?Y3djdzU4MWkybXBZbGZzMUkvTVJjR2JYcEl4eVp3UUpVYkxGL3VsWENVWFdM?=
 =?utf-8?B?VnV4Tm04dnVxczh5ZmFhdStLUDhEUGs4bEt3dnZLL2lBd3BHQWx3R290YjZE?=
 =?utf-8?B?RmNEMi9sUjFsZm9ENXZHYWhLU1hHano0UE82TTFlcGdPZkFqU0FRTXYwSDJD?=
 =?utf-8?B?NlJ1RlVKc2pYRXdNZFBaay9rbkNqZjlFeWdBK21qQW5FSlJkNkdUcHA4UG1E?=
 =?utf-8?B?cXFEd2hvdlZtc1FobEN6Z2RDSUVPa05IdFZCb2EvMWd1TVBJa0FWZXNRRVY0?=
 =?utf-8?Q?xKZ2fAuNeT/S4n1JCp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16c96a2-8796-4493-df66-08de73f45578
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 22:30:37.6166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHCOTRCSDrtmoCyivQrGUA/7QYM2HjdSfefskTVNxBosn1wDHqUS9DYnWs9jygiM5MGPP44W9yc4xOCL0Qn5qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB4725
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8975-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,DS3PR21MB5735.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 8780318D648
X-Rspamd-Action: no action

PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvY3EuYyBiL2RyaXZlcnMv
aW5maW5pYmFuZC9ody9tYW5hL2NxLmMNCj4gaW5kZXggMmRjZTFiNjc3MTE1Li42MDUxMjJlY2Y5
ZjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2NxLmMNCj4gKysr
IGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvY3EuYw0KPiBAQCAtNSw4ICs1LDggQEANCj4g
DQo+ICAjaW5jbHVkZSAibWFuYV9pYi5oIg0KPiANCj4gLWludCBtYW5hX2liX2NyZWF0ZV9jcShz
dHJ1Y3QgaWJfY3EgKmliY3EsIGNvbnN0IHN0cnVjdCBpYl9jcV9pbml0X2F0dHIgKmF0dHIsDQo+
IC0JCSAgICAgIHN0cnVjdCB1dmVyYnNfYXR0cl9idW5kbGUgKmF0dHJzKQ0KPiAraW50IG1hbmFf
aWJfY3JlYXRlX3VzZXJfY3Eoc3RydWN0IGliX2NxICppYmNxLCBjb25zdCBzdHJ1Y3QgaWJfY3Ff
aW5pdF9hdHRyDQo+ICphdHRyLA0KPiArCQkJICAgc3RydWN0IHV2ZXJic19hdHRyX2J1bmRsZSAq
YXR0cnMpDQo+ICB7DQo+ICAJc3RydWN0IGliX3VkYXRhICp1ZGF0YSA9ICZhdHRycy0+ZHJpdmVy
X3VkYXRhOw0KPiAgCXN0cnVjdCBtYW5hX2liX2NxICpjcSA9IGNvbnRhaW5lcl9vZihpYmNxLCBz
dHJ1Y3QgbWFuYV9pYl9jcSwgaWJjcSk7DQo+IEBAIC0xNyw3ICsxNyw2IEBAIGludCBtYW5hX2li
X2NyZWF0ZV9jcShzdHJ1Y3QgaWJfY3EgKmliY3EsIGNvbnN0IHN0cnVjdA0KPiBpYl9jcV9pbml0
X2F0dHIgKmF0dHIsDQo+ICAJc3RydWN0IG1hbmFfaWJfZGV2ICptZGV2Ow0KPiAgCWJvb2wgaXNf
cm5pY19jcTsNCj4gIAl1MzIgZG9vcmJlbGw7DQo+IC0JdTMyIGJ1Zl9zaXplOw0KPiAgCWludCBl
cnI7DQo+IA0KPiAgCW1kZXYgPSBjb250YWluZXJfb2YoaWJkZXYsIHN0cnVjdCBtYW5hX2liX2Rl
diwgaWJfZGV2KTsgQEAgLTI2LDQ0DQo+ICsyNSwxMDAgQEAgaW50IG1hbmFfaWJfY3JlYXRlX2Nx
KHN0cnVjdCBpYl9jcSAqaWJjcSwgY29uc3Qgc3RydWN0DQo+IGliX2NxX2luaXRfYXR0ciAqYXR0
ciwNCj4gIAljcS0+Y3FfaGFuZGxlID0gSU5WQUxJRF9NQU5BX0hBTkRMRTsNCj4gIAlpc19ybmlj
X2NxID0gbWFuYV9pYl9pc19ybmljKG1kZXYpOw0KPiANCj4gLQlpZiAodWRhdGEpIHsNCj4gLQkJ
aWYgKHVkYXRhLT5pbmxlbiA8IG9mZnNldG9mKHN0cnVjdCBtYW5hX2liX2NyZWF0ZV9jcSwgZmxh
Z3MpKQ0KPiAtCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJaWYgKHVkYXRhLT5pbmxlbiA8IG9mZnNl
dG9mKHN0cnVjdCBtYW5hX2liX2NyZWF0ZV9jcSwgZmxhZ3MpKQ0KPiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4gDQo+IC0JCWVyciA9IGliX2NvcHlfZnJvbV91ZGF0YSgmdWNtZCwgdWRhdGEsIG1pbihz
aXplb2YodWNtZCksDQo+IHVkYXRhLT5pbmxlbikpOw0KPiAtCQlpZiAoZXJyKSB7DQo+IC0JCQlp
YmRldl9kYmcoaWJkZXYsICJGYWlsZWQgdG8gY29weSBmcm9tIHVkYXRhIGZvciBjcmVhdGUNCj4g
Y3EsICVkXG4iLCBlcnIpOw0KPiAtCQkJcmV0dXJuIGVycjsNCj4gLQkJfQ0KPiArCWVyciA9IGli
X2NvcHlfZnJvbV91ZGF0YSgmdWNtZCwgdWRhdGEsIG1pbihzaXplb2YodWNtZCksIHVkYXRhLQ0K
PiA+aW5sZW4pKTsNCj4gKwlpZiAoZXJyKSB7DQo+ICsJCWliZGV2X2RiZyhpYmRldiwgIkZhaWxl
ZCB0byBjb3B5IGZyb20gdWRhdGEgZm9yIGNyZWF0ZQ0KPiBjcSwgJWRcbiIsIGVycik7DQo+ICsJ
CXJldHVybiBlcnI7DQo+ICsJfQ0KPiANCj4gLQkJaWYgKCghaXNfcm5pY19jcSAmJiBhdHRyLT5j
cWUgPiBtZGV2LQ0KPiA+YWRhcHRlcl9jYXBzLm1heF9xcF93cikgfHwNCj4gLQkJICAgIGF0dHIt
PmNxZSA+IFUzMl9NQVggLyBDT01QX0VOVFJZX1NJWkUpIHsNCj4gLQkJCWliZGV2X2RiZyhpYmRl
diwgIkNRRSAlZCBleGNlZWRpbmcgbGltaXRcbiIsIGF0dHItDQo+ID5jcWUpOw0KPiAtCQkJcmV0
dXJuIC1FSU5WQUw7DQo+IC0JCX0NCj4gKwlpZiAoKCFpc19ybmljX2NxICYmIGF0dHItPmNxZSA+
IG1kZXYtPmFkYXB0ZXJfY2Fwcy5tYXhfcXBfd3IpIHx8DQo+ICsJICAgIGF0dHItPmNxZSA+IFUz
Ml9NQVggLyBDT01QX0VOVFJZX1NJWkUpIHsNCj4gKwkJaWJkZXZfZGJnKGliZGV2LCAiQ1FFICVk
IGV4Y2VlZGluZyBsaW1pdFxuIiwgYXR0ci0+Y3FlKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+
ICsJfQ0KPiArDQo+ICsJY3EtPmNxZSA9IGF0dHItPmNxZTsNCj4gKwlpZiAoIWliY3EtPnVtZW0p
DQo+ICsJCWliY3EtPnVtZW0gPSBpYl91bWVtX2dldChpYmRldiwgdWNtZC5idWZfYWRkciwNCj4g
KwkJCQkgICAgIGNxLT5jcWUgKiBDT01QX0VOVFJZX1NJWkUsDQo+ICsJCQkJICAgICBJQl9BQ0NF
U1NfTE9DQUxfV1JJVEUpOw0KPiArCWlmIChJU19FUlIoaWJjcS0+dW1lbSkpDQo+ICsJCXJldHVy
biBQVFJfRVJSKGliY3EtPnVtZW0pOw0KPiArCWNxLT5xdWV1ZS51bWVtID0gaWJjcS0+dW1lbTsN
Cj4gKw0KPiArCWVyciA9IG1hbmFfaWJfY3JlYXRlX3F1ZXVlKG1kZXYsICZjcS0+cXVldWUpOw0K
PiArCWlmIChlcnIpDQo+ICsJCXJldHVybiBlcnI7DQoNClNob3VsZCB3ZSBjYWxsIGliX3VtZW1f
cmVsZWFzZSgpIG9uIHRoaXMgZXJyPw0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZp
bmliYW5kL2h3L21hbmEvcXAuYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL3FwLmMg
aW5kZXggNDhjMWY0OTc3ZjIxLi5iMDhkYmM2NzU3NDENCj4gMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvaW5maW5pYmFuZC9ody9tYW5hL3FwLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3
L21hbmEvcXAuYw0KPiBAQCAtMzI2LDExICszMjYsMjAgQEAgc3RhdGljIGludCBtYW5hX2liX2Ny
ZWF0ZV9xcF9yYXcoc3RydWN0IGliX3FwDQo+ICppYnFwLCBzdHJ1Y3QgaWJfcGQgKmlicGQsDQo+
ICAJaWJkZXZfZGJnKCZtZGV2LT5pYl9kZXYsICJ1Y21kIHNxX2J1Zl9hZGRyIDB4JWxseCBwb3J0
ICV1XG4iLA0KPiAgCQkgIHVjbWQuc3FfYnVmX2FkZHIsIHVjbWQucG9ydCk7DQo+IA0KPiAtCWVy
ciA9IG1hbmFfaWJfY3JlYXRlX3F1ZXVlKG1kZXYsIHVjbWQuc3FfYnVmX2FkZHIsDQo+IHVjbWQu
c3FfYnVmX3NpemUsICZxcC0+cmF3X3NxKTsNCj4gKwlxcC0+cmF3X3NxLnVtZW0gPSBpYl91bWVt
X2dldCgmbWRldi0+aWJfZGV2LCB1Y21kLnNxX2J1Zl9hZGRyLA0KPiArCQkJCSAgICAgIHVjbWQu
c3FfYnVmX3NpemUsDQo+IElCX0FDQ0VTU19MT0NBTF9XUklURSk7DQo+ICsJaWYgKElTX0VSUihx
cC0+cmF3X3NxLnVtZW0pKSB7DQo+ICsJCWVyciA9IFBUUl9FUlIocXAtPnJhd19zcS51bWVtKTsN
Cj4gKwkJaWJkZXZfZGJnKCZtZGV2LT5pYl9kZXYsDQo+ICsJCQkgICJGYWlsZWQgdG8gZ2V0IHVt
ZW0gZm9yIHFwLXJhdywgZXJyICVkXG4iLCBlcnIpOw0KPiArCQlnb3RvIGVycl9mcmVlX3Zwb3J0
Ow0KPiArCX0NCj4gKw0KPiArCWVyciA9IG1hbmFfaWJfY3JlYXRlX3F1ZXVlKG1kZXYsICZxcC0+
cmF3X3NxKTsNCj4gIAlpZiAoZXJyKSB7DQo+ICAJCWliZGV2X2RiZygmbWRldi0+aWJfZGV2LA0K
PiAgCQkJICAiRmFpbGVkIHRvIGNyZWF0ZSBxdWV1ZSBmb3IgY3JlYXRlIHFwLXJhdywgZXJyICVk
XG4iLA0KPiBlcnIpOw0KPiAtCQlnb3RvIGVycl9mcmVlX3Zwb3J0Ow0KPiArCQlnb3RvIGVycl9y
ZWxlYXNlX3VtZW07DQo+ICAJfQ0KPiANCj4gIAkvKiBDcmVhdGUgYSBXUSBvbiB0aGUgc2FtZSBw
b3J0IGhhbmRsZSB1c2VkIGJ5IHRoZSBFdGhlcm5ldCAqLyBAQCAtDQo+IDM5MSw2ICs0MDAsMTAg
QEAgc3RhdGljIGludCBtYW5hX2liX2NyZWF0ZV9xcF9yYXcoc3RydWN0IGliX3FwICppYnFwLA0K
PiBzdHJ1Y3QgaWJfcGQgKmlicGQsDQo+IA0KPiAgZXJyX2Rlc3Ryb3lfcXVldWU6DQo+ICAJbWFu
YV9pYl9kZXN0cm95X3F1ZXVlKG1kZXYsICZxcC0+cmF3X3NxKTsNCj4gKwlyZXR1cm4gZXJyOw0K
DQpTaG91bGQgcmVtb3ZlIHRoaXMgInJldHVybiBlcnIiLCB0aGUgZXJyb3IgaGFuZGxpbmcgY29k
ZSBzaG91bGQgZmFsbCB0aHJvdWdoLg0KDQo+ICsNCj4gK2Vycl9yZWxlYXNlX3VtZW06DQo+ICsJ
aWJfdW1lbV9yZWxlYXNlKHFwLT5yYXdfc3EudW1lbSk7DQo+IA0KPiAgZXJyX2ZyZWVfdnBvcnQ6
DQo+ICAJbWFuYV9pYl91bmNmZ192cG9ydChtZGV2LCBwZCwgcG9ydCk7DQo+IEBAIC01NTMsMTMg
KzU2NiwyNSBAQCBzdGF0aWMgaW50IG1hbmFfaWJfY3JlYXRlX3JjX3FwKHN0cnVjdCBpYl9xcCAq
aWJxcCwNCj4gc3RydWN0IGliX3BkICppYnBkLA0KPiAgCQlpZiAoaSA9PSBNQU5BX1JDX1NFTkRf
UVVFVUVfRk1SKSB7DQo+ICAJCQlxcC0+cmNfcXAucXVldWVzW2ldLmlkID0gSU5WQUxJRF9RVUVV
RV9JRDsNCj4gIAkJCXFwLT5yY19xcC5xdWV1ZXNbaV0uZ2RtYV9yZWdpb24gPQ0KPiBHRE1BX0lO
VkFMSURfRE1BX1JFR0lPTjsNCj4gKwkJCXFwLT5yY19xcC5xdWV1ZXNbaV0udW1lbSA9IE5VTEw7
DQo+ICAJCQljb250aW51ZTsNCj4gIAkJfQ0KPiAtCQllcnIgPSBtYW5hX2liX2NyZWF0ZV9xdWV1
ZShtZGV2LCB1Y21kLnF1ZXVlX2J1ZltqXSwNCj4gdWNtZC5xdWV1ZV9zaXplW2pdLA0KPiAtCQkJ
CQkgICAmcXAtPnJjX3FwLnF1ZXVlc1tpXSk7DQo+ICsJCXFwLT5yY19xcC5xdWV1ZXNbaV0udW1l
bSA9IGliX3VtZW1fZ2V0KCZtZGV2LT5pYl9kZXYsDQo+ICsJCQkJCQkgICAgICAgdWNtZC5xdWV1
ZV9idWZbal0sDQo+ICsJCQkJCQkgICAgICAgdWNtZC5xdWV1ZV9zaXplW2pdLA0KPiArDQo+IElC
X0FDQ0VTU19MT0NBTF9XUklURSk7DQo+ICsJCWlmIChJU19FUlIocXAtPnJjX3FwLnF1ZXVlc1tp
XS51bWVtKSkgew0KPiArCQkJZXJyID0gUFRSX0VSUihxcC0+cmNfcXAucXVldWVzW2ldLnVtZW0p
Ow0KPiArCQkJaWJkZXZfZXJyKCZtZGV2LT5pYl9kZXYsICJGYWlsZWQgdG8gZ2V0IHVtZW0gZm9y
DQo+IHF1ZXVlICVkLCBlcnIgJWRcbiIsDQo+ICsJCQkJICBpLCBlcnIpOw0KPiArCQkJZ290byBy
ZWxlYXNlX3VtZW1zOw0KDQptYW5hX2liX2NyZWF0ZV9xdWV1ZSgpIG1heSBhbHJlYWR5IGhhdmUg
Y3JlYXRlZCBzb21lIHF1ZXVlcywgbmVlZCB0byBjbGVhbiB0aGVtIHVwIG9yIHdlIGhhdmUgYSBs
ZWFrLiANCg0KTWF5YmUgdXNlIGRlc3Ryb3lfcXVldWVzOiB0byBjYWxsIGliX3VtZW1fcmVsZWFz
ZSgpPw0KDQoNCkFub3RoZXIgaXNzdWU6IHRoZXJlIGlzIGEgY2FsbCB0byBpYl91bWVtX3JlbGVh
c2UocXVldWUtPnVtZW0pIGluIG1hbmFfaWJfZGVzdHJveV9xdWV1ZSgpLCBzaG91bGQgd2UgcmVt
b3ZlIHRoYXQgYXMgd2VsbD8NCg0KVGhhbmtzLA0KTG9uZw0K

