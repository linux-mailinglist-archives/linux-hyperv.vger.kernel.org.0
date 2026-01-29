Return-Path: <linux-hyperv+bounces-8590-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD2iJxGge2nOGAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8590-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 18:59:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9C4B3528
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 18:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFFE730479F1
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 17:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12CB3559F8;
	Thu, 29 Jan 2026 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="K71Q43Lu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020088.outbound.protection.outlook.com [52.101.193.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3629A3559FF;
	Thu, 29 Jan 2026 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709408; cv=fail; b=MYZgQJp6zEMfHETeZou5VesypMP5s5AEu3PBJFrF0El0YG8VGbAacZuBX+xGDjx5npWVcXYKLTDEnBrf2nclPw3sF2+dkn9ROpYoRQymU8AX1rz16oe4pV51YQu2LkqumY3hxaztXkiwmXInVyjxNbSyPkld2FLX5uInitEmgik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709408; c=relaxed/simple;
	bh=/hmzc+NTEUmNjBwAKT7KseRD1M/9nqGkqyrprlNbLDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=shvAVV1bLdp1obKvUX5LJLqs9EJTtjP8bmRb0Ih+q1u6odzK/bzoWqdwbBrxD41dQUa6yVYKTEnivA5ts0ftcp2377GTovSK354APkdhcTk/FzDkVEG41fIviDJQWDtcVbfoeSBkXQ/7Z8Sx4Dq0jx7EpgYPb+OSTtVEj57q1KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=K71Q43Lu; arc=fail smtp.client-ip=52.101.193.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9A/h55tSkVvE2E0aFkx78Hs9lBshGeAOaHKD8v8n8euCouk6ZBQ4vJJARdgvKio11JG6aKylPCKcoNLARO01O/d9ZnPxsuYJJY6FSxMHKz6DtBspM3iNHn4G1SdNShWUjyjMUYVsKP4xHQgO6xdCykvpuUtP89yRUlayQaiu3lq2ziRY5wgOUvxm23dTGzfMpqB7HeU9j8HqJiHAyzdTTDGsKvwlh07WgasdYMKNsB8/+2EMTBdrtPGTV5gI8aHnedKXBRpNBQv710jYsGfeRA9TKOcc5yn+b4ehoghpxKinTjyEG4ajS5qFBxjDYMsC5jgZyAumtub4CcpViApmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hmzc+NTEUmNjBwAKT7KseRD1M/9nqGkqyrprlNbLDM=;
 b=mdo/Ihhmdq5LEtJvGNBO/cmFi8WA0dlzD5NihEmNIZS2SwysyYa5gxcLHtelIFQFhlNwrjrV7ndPTL0rDd9y61xtaqpnLwCuRi6cImYvbLsB5FqgNdR58vURivUgLlCqXq4xaX+VHQQRvzpKCX9cii5b60PVmgsfzDSf/DCr0xT+V1/TUTeUAJtg5ycPc/9/XK1xP4GCMDgVIKSLPtsga0iN+7Q4mHhu+J9U9jXRoEtF/bsJL+wncPzWF/nREhcY/5SwXa6fWpTaYWPYiZHiE31cQfNo+fc/zEB8jnF1QAssHTEf27gfKDoa52qpciALFn6gBmIvzfH6TjncXnWpJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hmzc+NTEUmNjBwAKT7KseRD1M/9nqGkqyrprlNbLDM=;
 b=K71Q43LuGFZwOilT1y4gasGH5tEJGLd9rJoNfLQbfJ2rEbm+LdK6nR6BYxTUEdmoT5xZgf4IwTtFFCsn8OzeerT7WXgmchRB81+/RQ0ef2gUfDAcZTxNTopos0JVqkkwOiww2osPURR6OPbl63s/JeqPTKePrNhF9aqzKEkdaec=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS4PR21MB5032.namprd21.prod.outlook.com (2603:10b6:8:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.4; Thu, 29 Jan
 2026 17:56:43 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%3]) with mapi id 15.20.9587.001; Thu, 29 Jan 2026
 17:56:43 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@microsoft.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH rdma-next] MAINTAINERS: Drop RDMA files from
 Hyper-V section
Thread-Topic: [EXTERNAL] [PATCH rdma-next] MAINTAINERS: Drop RDMA files from
 Hyper-V section
Thread-Index: AQHckDxFcmxQHiYJR0S+Y6Se3xSt0rVpcJAg
Date: Thu, 29 Jan 2026 17:56:43 +0000
Message-ID:
 <DS3PR21MB5735FD83EEC90609560EFBF0CE9EA@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260128-get-maintainers-fix-v1-1-fc5e58ce9f02@nvidia.com>
In-Reply-To: <20260128-get-maintainers-fix-v1-1-fc5e58ce9f02@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e2ffccb4-1bbd-47fe-84bb-ba826c75c56f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-29T17:55:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS4PR21MB5032:EE_
x-ms-office365-filtering-correlation-id: 99345de7-536c-459b-2414-08de5f5fc372
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OG81M1RiMUcyUUtLOVUvOWtkcWtwN1gzckUyc2JVMWVPOWZYcFZtemhsUXNo?=
 =?utf-8?B?ZkVuNmdmNEdKK1A1TUFJVWNyM0pxYUZSMC9PdmQ3RTViVU4rOEd5QThjMkVY?=
 =?utf-8?B?VDUxQ2hKMFVCZFBDdzBmR2lSWHl3ZXgvQlVLanBlcjBWdjVaMTh4eERxaEd4?=
 =?utf-8?B?TkRoOTJoT2xpNmt1cDhOSTlHc3I2Yzg3aFlhZEh6cldKemcvcjhWTEEvbTFI?=
 =?utf-8?B?SnVTZ3YybVdxblBUWFJCNzlQVzJ2WlVLMlZDVCtwNllZZ2R4ZnZxeEU4Zy8z?=
 =?utf-8?B?MDBNSkxJbEFpRll3bDcyZzdjU21EQ2NlR1oweGxXY1JWU2pHamJaeFowcTJ6?=
 =?utf-8?B?WTZMODAzYWhrcEpDc3N6WHRtaFRNWjFPRG8xNlo4RTdsdEwzcDZqTVVzeHNE?=
 =?utf-8?B?YlFBM2o1a1B1YjBheGQzN1lveGxmVVZWR3d1R1NBbE02cWdSRTBMNzl3WmJK?=
 =?utf-8?B?a3Y0dTBYTXgrNlgzRHNnVDhnWDc1L1lpcmdlTlM3S1YwdlJMS2luWitOSjVD?=
 =?utf-8?B?alh4bVlFNE9zL0VLcWtnNlJaT0QrRnNLTW4wc25vQWpEc1hnQWhKaFhVVTVX?=
 =?utf-8?B?MXh4TUtFbFZ3MlNGRENsMEJzenJVdVMwWVBIY2V2ZzNLR1N5R1hxTFp0UkR4?=
 =?utf-8?B?OXR4b1FERExwQVRIb2ZMVytQbC9YZW5QOFFvNlhiUzh4MEYzRlJ3LzhxZ2Uw?=
 =?utf-8?B?aGxDejgvQWFsYWFvY1h4WnJGa2FYLzNVdHhDMUswaFpuSW94NDJET09RZUcz?=
 =?utf-8?B?UkUzdVdENkRkcUhiQ240V1BaNHdlbTBrWXJZaEJrZlRzOE9Zc3Mxd3RWdkVX?=
 =?utf-8?B?WkxEU2ZIenphdXN0NDNNN1B3MWxrbzVuRGVkSEdscnZPU0JsdkQrVlJpaStJ?=
 =?utf-8?B?anVHdldZaWVMVnAvQ2dhOE1FZW5UUWVaOWJNb1JaY05BVzdrRFhIRnM4VmNa?=
 =?utf-8?B?YWQwelN4VDN5eVlTY0xWeXh3WlJvSkhiakk4R0ZsTS9mU0pOaGlWZWIyK1hr?=
 =?utf-8?B?NUUxT0EzN2c2Y1dVVEhnWHNtMjB2NmlhLzhOOTZDeVAya0tQbFhWSUlTc0pi?=
 =?utf-8?B?MXNydFRzbnBIT2FVSmZuMXVPdEVrZThyYS9FZm4reHZwZVNJUE5NM0pzaWdk?=
 =?utf-8?B?Mkk5NVRVZ3pLSUtJczNIcW1lb21uODF1QnphaDg1Qm9ZWUNpQ0QvNjJqQjVm?=
 =?utf-8?B?RXdlaEM3c09zMUVYaDBvS3BWYkhRSlNXV2QwVW9McTBhRWRJMFJEL21UZkRG?=
 =?utf-8?B?YUJ2ZWlXZ0RDQXRqcWF3WWpieE16Wm02TE81cEJsRTlNQVpidnlISS9qSXpR?=
 =?utf-8?B?UVhKa1h2K0VTdnNWUFNESndBVS9GckxyR0dnVnJDczkrL3VRV2F6WE81N3Zu?=
 =?utf-8?B?OGEvcXp3N1V5aDNNU0lZZHc0V3U0VlFzcnBRR0N2ekdLN2pRWUJpcCtQeXR5?=
 =?utf-8?B?UXdMMFlxVGlzd1M2QU9NU1M3VlBVYUpobFlhcXlkbjBJc0lUSUZQeVM2SmJN?=
 =?utf-8?B?Qis0V0lLb3R5dnhYOFcyUW5oc01McFM0WHp4dmxmN3B3ZWhLamVPL0VFUDJs?=
 =?utf-8?B?VytIeGVkeGVjR0Q0b0lpN1BSd3V4T09VSmVBaUs4ZFRLSGx3K01iaDhOMjBB?=
 =?utf-8?B?dm9yMnRaQUcva2RnQTY3SHpobThzNWRMU0w0Tk8xVVp2YUUxQmlDVlB0V0hC?=
 =?utf-8?B?Z0FvdmNZZ3o0Mkc2OXIyUERZdGx2L1pGeVBRRHdESjNUdGJhdDNhbmMzQk5t?=
 =?utf-8?B?QUhDUENNaTlOQ2NHck1RSzc4TWUrNksrY3g1cDVVVzdRb0RMNHFwTERIT1Mw?=
 =?utf-8?B?OXhNUWRBNVhZUWFOdjlqWDBuUGpKeFF1emEwOEtuUDYvVXMvQzljWmtXVTkx?=
 =?utf-8?B?TDY5N2ZkQlVvamo4K3hZUkNqUWg4U0FJSUJ3N1pRVVBDdDk3Z1lvK094c2k3?=
 =?utf-8?B?bTV0RjFid2owdjZVZXlTeEpZMVRSMHF2L0p6b2ptOXhwbXoxbElEZDE1cFY3?=
 =?utf-8?B?dERUcWd1M3hqMW9kbGkxM1JUQjc0enY0V29YNGdCTFE2KzEwemprREhnVW05?=
 =?utf-8?B?M3pOSVJVck9XOW45UC94TmJJdnBVYnZLNmdJYWU3aG9KcGREVGZWS2pLbGcv?=
 =?utf-8?B?bmdzVmVPLzR4VkovdHpFRTNBcThOVG1ETjE5QVkyUEh6ZGhYMzNoTDVHOFdP?=
 =?utf-8?Q?97Hgi3XozXPBkpfK+pL1W6Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RllsQ2hPYXZockJsbm11RytqR2Q1Tks4ZEtzbFEzNWgwSHdLTWI5QjJTa044?=
 =?utf-8?B?NjFSV0pRajJqeXRiaVdZb1YvYkhKZzNlTVVPdXRUK3htNzZ4aDF2TDMzS3JZ?=
 =?utf-8?B?OXQ5L1BvV0hjQ0RXR0txcDNzb0lSZHBUbEhkZ2JNVmFsNWdSaTdKVEdCL045?=
 =?utf-8?B?L3M2c3VLZzZpU3FnR0EvbVFPUjY5QTB1cnlUVVFKaUoxcHo1MHBENWNFajRE?=
 =?utf-8?B?dXdrM2h2TlAvRjU3TndINGFFOWhEZlpqdVl2YmV0M2tJL3dzSHVoTko2ODh2?=
 =?utf-8?B?YzlLMG1kcCs0RmpuQjFENmlUTC95aFUxWkdMOUhNRmIrREd4UjFzYitienNw?=
 =?utf-8?B?NCtjdUoxSFkveWJsdzJkbUJ6TFpmRlBBSEFjY0NjYjNGa093NnFkbjc3OFlQ?=
 =?utf-8?B?TGV4OVY1NlExaDVyTjArQUxkbkl1L1pNOS84OFVVc0w0WEprVGtsV1Z2RmZq?=
 =?utf-8?B?a0U4bXQxV1JJa3kzTUcyOEdnZ3pvQXhjUnoreTNPeGJwYi9namp1T1JNOGY3?=
 =?utf-8?B?aHRZd3hqN3dXb1A5S3VmdFpuNjRheGhGNThJakVGWEtLREg0bUNlczljejZQ?=
 =?utf-8?B?R2FOZlcwTzBZYURpTjB3cUQyVFI2eEl6L2RSSEV0ZGNaSkZiMzFRclRyQ1hm?=
 =?utf-8?B?RzZFM0E4bnZqWWVYRUljNllrSGpIb3ZyWDErK1lnbjFkZ3A3TEpLRk9CbkZM?=
 =?utf-8?B?SjlHYld3RmhEUVFMaU84bWw1T3pwOGN1cDJmd3B4dW9GTG1PSURRVEN4SFlu?=
 =?utf-8?B?UWtBeGVCd1NQUEFhdWYxaDVNbTNOOSsvSDBkdS8vOXNsMk1PTk9KbFhwRjR5?=
 =?utf-8?B?aDZVaDBoTHYrL25qcjBUQ2tYanZ6NkNlQitSTzNtV1RwR0ZJSUZvNXo1bnRS?=
 =?utf-8?B?NllWc3Q5UU0veUlGWGptYjFzeGdzTVZKbVk1cy8wQzZrRmh2a1NVQXIrTmVT?=
 =?utf-8?B?d2ZSMFZDZFUwbDQwb2I5cWk5bk1JSWxVRkt6bWRRNUN0SXJNWHR3L0drRXow?=
 =?utf-8?B?L2FWVFZ4ZEI5NVRqc0lFQ3p5M0MrK2d1V1BUTXExYnpiUXFtbUw5SXRKQ2t4?=
 =?utf-8?B?azU5R2YvYklwUWNBbitlbHRlRFljRW91WlhvYWNDdTNETzQ5dUVXb1h2SXhX?=
 =?utf-8?B?RXRuT2NGbnA2SE92YmdabUhpdmhVU2haenp1Y2NyMlMwTEZYRDdZOGU1SjBT?=
 =?utf-8?B?TnF5LzZPMUIwR2ZHYWtBYndLcHpMK2I1WjFTQm93bHRyZlZ0ck1GV0laR3Jy?=
 =?utf-8?B?RXNuWElUQUxONXdtNkxrUXFBU0M1b1V4WitiazVoaGtrZnRWRWlqL1hpQ0N6?=
 =?utf-8?B?dVlYd3RLenJTNmtVOVZEZ0NyZ2RITGpheWxrc2YzQUlKUzNYSlRGZzdvSXlv?=
 =?utf-8?B?eDZBaDBZRnVUNnU5S0I1cUN2NXpaK0IxRzczUFpUcWpET1c3QTB3ajM1SHJY?=
 =?utf-8?B?emdGdHUyVCswTkRJVUoxa0o0RSsrZUd6SFN2ZEY1RVNWMGo4ZDZFMW90THhn?=
 =?utf-8?B?azRTYmhqUEZEWXBGR21KT1g3bmcyN09uMklSM0FrM1pybjYzOEFKTHBJSmZi?=
 =?utf-8?B?OHpXZ1N1NWZ1Zk5GSzlnT2s5cUVDRjFoc0hNNnRNZ2RTUW1QZi9FME9vTUVn?=
 =?utf-8?B?ZVpVWkhqRWdsRXViVUFwbXAxZVpNN29acTNxSjkrZnk3SThYWC9VTWdHVjBp?=
 =?utf-8?B?VXFGaVZ5RytHd2NjSEJsZDZrTWJiMEgya01JRWU0d1ZpcnU5Y1REbVV5NE9k?=
 =?utf-8?B?MjVxb2EwcitlS2Q3RE9RVW1xeHl2UGhQNFZDdjJxejVDUlZOT0xjM2Nxa2VP?=
 =?utf-8?B?VGtTNHVFRmJ0emt1eDdmbG9JSkZlYzl3TlRTM0xyMjQ1QS8xTkJkbGdtRGk1?=
 =?utf-8?B?VitxdFpoayt6dVljcXV3Rk16aG96WWFrclUzUE1XRjd5RitnNjBQK3BQeGto?=
 =?utf-8?B?eWNkV2ZmaHFDOUNNaHRhMjBjVVd0c0dDNGhXeFZmemJvYWN6N043OW5oNUJE?=
 =?utf-8?B?VmttNDdMQmxEakdlYWxWcFcyVjdGZDV2SGlTRnR5QnlQdGN1NS93N1hzcFJR?=
 =?utf-8?B?RDB1MC9rZk5sSWNFMFFBV2FIc1E1OXQ2RUsvSFZRaXkvaEZDRXQ0SVJKY0w0?=
 =?utf-8?B?ZnFuaHh3S0JwVmloNEk4UHJ1SHcwVitCcVo2YkYxWHNuaU1tWmd1b2JlUUFD?=
 =?utf-8?B?cGtjZnBOYlNJbUo2dkdJWUV6UmM0M3hOaWZ0T3ViUWVyZ0lpdWlMbU9aSXpk?=
 =?utf-8?B?Qm9FYW5NNFhzV0h4aFk2Ym85SnQ4TWRIVFd1VkYvN3F4dGxCM3RzbWMvcE9G?=
 =?utf-8?Q?wXN9FvJpc0SV9HVg2p?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 99345de7-536c-459b-2414-08de5f5fc372
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 17:56:43.8348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+AW8ZMDe8SqOfk1klFvnJua1UKQR0tX2ZWvye+vNkv6aCoqdNaL+9pqb9sm5oJfxvAF+SVA3RwGRdARbH1rmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB5032
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8590-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 1E9C4B3528
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyOCwgMjAyNiAx
OjU1IEFNDQo+IFRvOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT47IEtvbnN0YW50aW4g
VGFyYW5vdg0KPiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+DQo+IENjOiBsaW51eC1yZG1hQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBb
RVhURVJOQUxdIFtQQVRDSCByZG1hLW5leHRdIE1BSU5UQUlORVJTOiBEcm9wIFJETUEgZmlsZXMg
ZnJvbQ0KPiBIeXBlci1WIHNlY3Rpb24NCj4gDQo+IEZyb206IExlb24gUm9tYW5vdnNreSA8bGVv
bnJvQG52aWRpYS5jb20+DQo+IA0KPiANCj4gDQo+IE1BSU5UQUlORVJTIGVudHJpZXMgYXJlIG9y
Z2FuaXplZCBieSBzdWJzeXN0ZW0gb3duZXJzaGlwLCBhbmQgdGhlIFJETUENCj4gDQo+IGZpbGVz
IGJlbG9uZyB1bmRlciBkcml2ZXJzL2luZmluaWJhbmQuIFJlbW92ZSB0aGUgb3Zlcmx5IGJyb2Fk
IG1hbmFfaWINCj4gDQo+IGVudHJpZXMgZnJvbSB0aGUgSHlwZXItViBzZWN0aW9uLCBhbmQgaW5z
dGVhZCBhZGQgdGhlIEh5cGVyLVYgbWFpbGluZyBsaXN0DQo+IA0KPiB0byBDQyBvbiBtYW5hX2li
IHBhdGNoZXMuDQo+IA0KPiANCj4gDQo+IFRoaXMgbWFrZXMgZ2V0X21haW50YWluZXIucGwgYmVo
YXZlIG1vcmUgc2Vuc2libHkgd2hlbiBydW5uaW5nIGl0IG9uDQo+IA0KPiBtYW5hX2liIHBhdGNo
ZXMuDQo+IA0KPiANCj4gDQo+IEZpeGVzOiA0MjhjYTJkNGM2YWEgKCJNQUlOVEFJTkVSUzogQWRk
IExvbmcgTGkgYXMgYSBIeXBlci1WIG1haW50YWluZXIiKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTog
TGVvbiBSb21hbm92c2t5IDxsZW9ucm9AbnZpZGlhLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IExvbmcg
TGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KDQo+IA0KPiAtLS0NCj4gDQo+ICBNQUlOVEFJTkVS
UyB8IDMgKy0tDQo+IA0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiANCj4gDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJ
TkVSUw0KPiANCj4gaW5kZXggMTJmNDlkZTdmZTAzLi5kMmUzMzUzYTFkMjkgMTAwNjQ0DQo+IA0K
PiAtLS0gYS9NQUlOVEFJTkVSUw0KPiANCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gDQo+IEBAIC0x
MTczOSw3ICsxMTczOSw2IEBAIEY6CWFyY2gveDg2L2tlcm5lbC9jcHUvbXNoeXBlcnYuYw0KPiAN
Cj4gIEY6CWRyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMNCj4gDQo+ICBGOglkcml2
ZXJzL2hpZC9oaWQtaHlwZXJ2LmMNCj4gDQo+ICBGOglkcml2ZXJzL2h2Lw0KPiANCj4gLUY6CWRy
aXZlcnMvaW5maW5pYmFuZC9ody9tYW5hLw0KPiANCj4gIEY6CWRyaXZlcnMvaW5wdXQvc2VyaW8v
aHlwZXJ2LWtleWJvYXJkLmMNCj4gDQo+ICBGOglkcml2ZXJzL2lvbW11L2h5cGVydi1pb21tdS5j
DQo+IA0KPiAgRjoJZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0Lw0KPiANCj4gQEAgLTEx
NzU4LDcgKzExNzU3LDYgQEAgRjoJaW5jbHVkZS9oeXBlcnYvaHZoZGtfbWluaS5oDQo+IA0KPiAg
RjoJaW5jbHVkZS9saW51eC9oeXBlcnYuaA0KPiANCj4gIEY6CWluY2x1ZGUvbmV0L21hbmENCj4g
DQo+ICBGOglpbmNsdWRlL3VhcGkvbGludXgvaHlwZXJ2LmgNCj4gDQo+IC1GOglpbmNsdWRlL3Vh
cGkvcmRtYS9tYW5hLWFiaS5oDQo+IA0KPiAgRjoJbmV0L3Ztd192c29jay9oeXBlcnZfdHJhbnNw
b3J0LmMNCj4gDQo+ICBGOgl0b29scy9odi8NCj4gDQo+IA0KPiANCj4gQEAgLTE3MzE4LDYgKzE3
MzE2LDcgQEAgTUlDUk9TT0ZUIE1BTkEgUkRNQSBEUklWRVINCj4gDQo+ICBNOglMb25nIExpIDxs
b25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gDQo+ICBNOglLb25zdGFudGluIFRhcmFub3YgPGtvdGFy
YW5vdkBtaWNyb3NvZnQuY29tPg0KPiANCj4gIEw6CWxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3Jn
DQo+IA0KPiArTDoJbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9yZw0KPiANCj4gIFM6CVN1cHBv
cnRlZA0KPiANCj4gIEY6CWRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hLw0KPiANCj4gIEY6CWlu
Y2x1ZGUvbmV0L21hbmENCj4gDQo+IA0KPiANCj4gLS0tDQo+IA0KPiBiYXNlLWNvbW1pdDogYTAx
NzQ1Y2NmN2M0MTA0M2M1MDM1NDZjYWU3YmE3YjBmZjQ5OWQzOA0KPiANCj4gY2hhbmdlLWlkOiAy
MDI2MDEyOC1nZXQtbWFpbnRhaW5lcnMtZml4LWE5MzE5ZmM5ODVjOA0KPiANCj4gDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IA0KPiAtLQ0KPiANCj4gTGVvbiBSb21hbm92c2t5IDxsZW9ucm9AbnZp
ZGlhLmNvbT4NCj4gDQo+IA0KDQo=

