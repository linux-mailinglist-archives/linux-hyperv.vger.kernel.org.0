Return-Path: <linux-hyperv+bounces-7361-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E20C16A04
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Oct 2025 20:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C169D3569B3
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Oct 2025 19:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A06C34FF69;
	Tue, 28 Oct 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hLZDLYSD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023113.outbound.protection.outlook.com [40.93.196.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B334FF4E;
	Tue, 28 Oct 2025 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680169; cv=fail; b=ejAPbv4Rfq9j6hJcc/WTx6mxO5kaSp7CYz3gDViZPEGvDSsP3nDsjqFOpaDCHlVFrKcBxAl0s+NVSs5eeblH+MK8fPgpw5sj87k6m7WzYCqk3H8XqECAryBzYXM3jgqzl6DapFrQxEBrXf0eMjsxjYDpPib8ZOIwq1upxsSB/j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680169; c=relaxed/simple;
	bh=EQLa+X/xHO8XR5ZmDiNiO5wOzndcRoz7AKYhhrkv3QI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NG4p9xIBtFZ5+HUnQPbWPU/+jio4USjjtZk9IVAb7ZmL6ybkB5PLZt/MrdWsjbFRWfQs9XC5/MggTLWWxH7Ioau+c9dhYNg5aH4YvM4Hq0k1IIP6i54IlM23i0Q3XBtYg/zNj06ZSy4yLZ302g79nY1GnfOQZdGHWeOmczZ0Czg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hLZDLYSD; arc=fail smtp.client-ip=40.93.196.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6b26hbFYuVAFFuSdB8ObRF9hWfFIEvqdEBWv6rz22SjYE1Aq5Ux/V+V7C165AtZnNNDNqCPfDD/aWGD4l2IfErGxlPPiwgq4FGImG/G5znEl8g0/hwxRSS2i87drC4Uf79ejy+mI3gAHwJNOyP0rx9aFV+RoGv4FnLcvYIhGnFGzQR9Qyu6ZuV9Va337bCFSGwzNB+obP4dVgCbmAPaEqoRayiZbRm10KMWph2TYgrTXBrzsq9ZbB2XurKq+oEGOg/9TKZUaG1qhJSCmmV03afDfhi8UIY5aHifuLPAYcd+p1Sv5+YDcDT9nOyuSS/aNxOPcE9eO+9sx7T1G4KY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQLa+X/xHO8XR5ZmDiNiO5wOzndcRoz7AKYhhrkv3QI=;
 b=aI2wbWL56jLGg/27e0NlkBvk3vOw/D0Kw5UUWQppd9nk0cUuV1r7gluLreZcpWUQTSxFJ2+cP5upSfB8hVSQOWQlxBdQUpaTHBfCQlrM1kq2clCHKy3k1yuts6brspoFE61TVYCsCY7yOGTbo05ukh2zGQ4lUavJUuRgw5Ws4pitQmkptDssILIn9dhptmmLqWKRS3DgYeRDTuy+iYmiZIJMCrHH02FpXvXMaZQPNxXbsvYl05qEOa+jPn0glgZL35rFXFOpB+Yes4XZT7qmVUyfLGd26qBTLCsdpZG5M5jH3R/8sZE3acUhBz2wF1o38Y8M09eSUZaViRjO9mcWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQLa+X/xHO8XR5ZmDiNiO5wOzndcRoz7AKYhhrkv3QI=;
 b=hLZDLYSDhlnyMrQ3XdjDGayAATlglb2G3SiqMyJZmUMVLib60IsS8kYTFkF1cIkxLqAqx/IK4mgDENjuhOmXPb4guGE1d8cEmcrn72tldxVbo7O2w6PrWfbuaAKKWDNgrrutcKGilrcv8pcR7am+Bnuie9DkdzMLjKaBboFa7w0=
Received: from BY1PR21MB3870.namprd21.prod.outlook.com (2603:10b6:a03:525::7)
 by SJ0PR21MB2014.namprd21.prod.outlook.com (2603:10b6:a03:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.4; Tue, 28 Oct
 2025 19:36:03 +0000
Received: from BY1PR21MB3870.namprd21.prod.outlook.com
 ([fe80::9faa:4fb0:486b:8267]) by BY1PR21MB3870.namprd21.prod.outlook.com
 ([fe80::9faa:4fb0:486b:8267%5]) with mapi id 15.20.9298.003; Tue, 28 Oct 2025
 19:36:03 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
CC: Dexuan Cui <DECUI@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"ernis@linux.microsoft.com" <ernis@linux.microsoft.com>,
	"dipayanroy@linux.microsoft.com" <dipayanroy@linux.microsoft.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, "horms@kernel.org" <horms@kernel.org>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "yury.norov@gmail.com" <yury.norov@gmail.com>, Shiraz
 Saleem <shirazsaleem@microsoft.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [net-next, v3] net: mana: Support HW link state
 events
Thread-Topic: [EXTERNAL] Re: [net-next, v3] net: mana: Support HW link state
 events
Thread-Index: AQHcRIdkXDiS4CvhKkmBHWd5T/YuT7TXpggAgABR2hA=
Date: Tue, 28 Oct 2025 19:36:02 +0000
Message-ID:
 <BY1PR21MB3870D5B860FB1F26932EB73ACAFDA@BY1PR21MB3870.namprd21.prod.outlook.com>
References: <1761270105-27215-1-git-send-email-haiyangz@linux.microsoft.com>
 <76598660-8b8e-4fe6-974b-5f3eb431a1ec@redhat.com>
In-Reply-To: <76598660-8b8e-4fe6-974b-5f3eb431a1ec@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: paulros@microsoft.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f8981a10-7d18-4759-ae8c-91a821086891;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-10-28T19:24:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR21MB3870:EE_|SJ0PR21MB2014:EE_
x-ms-office365-filtering-correlation-id: 6bb1ad9c-91d5-478d-84cc-08de16593af3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TlpxK3dFNFBxcllJUHAxMHJJNGVZcHdoUnR4MWE2VkJ1dERCMm00UHdNTWpq?=
 =?utf-8?B?Njc5Z25kM2h0RXM3aXhtYm8zY1JqSHQzcEIyemhQUHFhbjI1Ui9FSXg4eUc5?=
 =?utf-8?B?eVJqRDFJS2xYWis1ZGlVaFRIbGNVSzRYcDNZQWluYjE5WHZwNVdpVFdmaGNi?=
 =?utf-8?B?M2JzM3AxVnRrandrVXdqNEozWGF4V3dvbGtnV0ZiUFY5K01zMDBwKzVNcGFu?=
 =?utf-8?B?dm9nZ0VOYWhNRjZ3OWlyd3VBNkFLdTZ6Mnpqa09ZcDZYemtiZ0JoMGMwUHUy?=
 =?utf-8?B?VFBMOHlZeVZXUHhCVDRsdXBaNDlqcDdKa1ZxQzBNWnRnbWY3OHM2WUJjTDZD?=
 =?utf-8?B?UlliQk9ialdLSFFUbmpxZnE0OWh6bU94Wm9SSUw3a2xPV2RhMVNVSGJaaURK?=
 =?utf-8?B?L0tNQUJ0YjgzRzlxWjZwZjZ5MCt1dW5rWjZSNGU5ZDJGVHh1VzZsZEZ2Uk84?=
 =?utf-8?B?ejJ3Zk1aTnl5Y0FCamVVYzY3bG1JYU5VSklnaHBDNk9yeEltL2NxVmJDN2xY?=
 =?utf-8?B?b2pVOThJRFlhVXdXZDA4VVYxT2VpRUVDN3lQRmRQV0JwZmtYc2xET21OWS9u?=
 =?utf-8?B?Q1lOU0MxNVFWWXUvZThUaHB2eUU2VC94eDNxL2RtR1Z5TGxWd0Zuck0rNHYy?=
 =?utf-8?B?R0JIcTRCUHEzWHhpNU41cWdRdmE1KzNRN0ZSMTVIdm80T2JjUGtaZERqTmFR?=
 =?utf-8?B?SjJlYVNmclIwbUx6QzBmNzRyVUFDVzNpQzB5TE1uRi9RcnhIc3VEQTZLanpO?=
 =?utf-8?B?T2xxOCtxQkJ5L2hqOUdZSWVlWWY3ZEFGYlFCNG1XY2hLZXRGNkVJZi93ZEVG?=
 =?utf-8?B?d0FlUTQ5aExBdXZ1UU5MMm1SbHRnS0tLSDY2Vm1nMXNBSmhEeTFkZjZuNVNO?=
 =?utf-8?B?U1hiRm5EU2ZkakZCeGVqOXV6TCtodUVnY3RJRkNCL2RZTWFHdW9jSXYxd3VO?=
 =?utf-8?B?cGpEbXo3YWcyY0l1S0MrNjhuVHVkK0NteGhrWFpLNys0TEp6dW9PV2xCTXpY?=
 =?utf-8?B?dXlPZURNQXBQNjI0TTAxWjFDY21PQk5jN25sREVueWRXVmZOQXpIOUkvU2Fr?=
 =?utf-8?B?azJuZHFTZThnSW9CRmo5K0dYNmFUVkVweHlhejk1aWVwTkdZY0VYN21TN3pa?=
 =?utf-8?B?TUZwSG4vamthZUY5OGo3cjVBdk1MVlFDNXcyamplbWxtQXVEWGtTODdHY2pZ?=
 =?utf-8?B?djVrVGs4QzlRZVRpOG8wM1E3clRTMWdEREd2bWNNcXZ1Zy9vZms0TlVXWXFH?=
 =?utf-8?B?Q0xSaC9nNituWm5FbHJOQytTR1VPVmY5ZUdSZm5NSXdRbXEvSG1FRlM4MTBC?=
 =?utf-8?B?Wm1QYVZLZnNkcGFYWWY5cVd2K3JIYkpKdkVnc29icUFXU25XWmFYNHZYS0Z3?=
 =?utf-8?B?NXV2Qm5CalBRRk82MUVtNEpGcGVoa0I3djZPcXEyME1qSEk0RElSdVZLcENo?=
 =?utf-8?B?RHl6NWdBUDFoYzllUXNOSEF5MnQxM1hLSkY0SDNzUlJ3ZXJiMFVrVWc4WXRy?=
 =?utf-8?B?QUFCaHRkc0wyYS9EOC9SQVBQVGdVdllDZkt3RGNWNWV0OHJVd1A1Mk5jM0hC?=
 =?utf-8?B?VWtEWFlhUVFnb3g5SXpKSkk0Z2Q4WlVFQk5FclBkcXZJV2FwM3plc1Q3aWFJ?=
 =?utf-8?B?KzBjT1UvUHJTUkxqZ0IzSnh4WVZjZ3VRMGNsV1pITEJxN3RaUmRCTU1yWmJw?=
 =?utf-8?B?N1UrbFI4elNMS3ZkM1dCWWNiNThQZ1pYcXRiOWF2SjFJSWNxaWNCU1VOYXpw?=
 =?utf-8?B?MC9DREtSRWpoc25KdC80SWtYYVFPQ0xDQUk2NG9CRkdmR1hiN0dSUm1qdEFh?=
 =?utf-8?B?NnBwUVU3eXVOaDI4dXlXUmVkeUI5dko1UjZPalF6WnpuRnViZmlyWitMRmdr?=
 =?utf-8?B?dXlPd01Cb1A0d0hjbUJzbVZlUmx5a3V5c25QcmlFOVYwNHpwQmtnT0x1OXhQ?=
 =?utf-8?B?cUIvV2xsZnY4aHM1N1BnRExYLzEwQUFOWUZqeVFNQzA1OU9QdTRZQWRZZ212?=
 =?utf-8?B?R3EzOW1yaklFcVBiS2Z5TTVwSTMvNUw4UE1yM1lhbFFFZ2hxZzdldWIwOC9C?=
 =?utf-8?Q?pOPOzo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR21MB3870.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alRCdDFacDEyTFFlZEJoUElMRllnWGdmV0NBN0xFNUZYb055VnhaNWRmY09x?=
 =?utf-8?B?MGRKN0FvZXorUHIxUGl3emU2NzRtdnV3VkZoTURXbzFwbDhsSzhnR0QrZGRM?=
 =?utf-8?B?WC80bmFuVWFlUmdDZGVxdGhYU2daQk04c3FhN3ltMldXanpxTDc0ZWFCbE9r?=
 =?utf-8?B?N2VVVkUxSVcwN3hOeXQybFFXWUFGbnFzMk1nVkdpTHc0OE5Za0ZuRXJ4aEVp?=
 =?utf-8?B?WGZtM1dSSmpKcjdwMGxtWTBLUnYxN2xjQWpjU3Z6N2NPU25lL0RHQlpxbE9U?=
 =?utf-8?B?YWFhSEpxZDN6a1E2ZGFGYVhaQXdaKzVOclZQdlhjOGdkQms2R09uKzI3Q1Fi?=
 =?utf-8?B?OTJpTTB0OWZpdm1OL09JY3lGL0FZTUVVbGtOZE9vM2Z3Zkp3WFR3bFhZNkxx?=
 =?utf-8?B?Y1FCWHB3WWlQbmpudlF4ZmtzN0I2Q3BrL3g4YTdVTm9tLzZOVEZvV3lScmx3?=
 =?utf-8?B?Zis0ZEo2SUswVldsWjBQWEJ2b0FNL2tydFRrWE5BSHhZN0ZKbXJGR1h4U3Nq?=
 =?utf-8?B?YnRIRXdraTBCNHpJcHRUSHNjZFhXa3BhNjFNc28yRlZDSnNlKzJNT2xyUk1O?=
 =?utf-8?B?aityeGFIZkJKdkRpVEZFWkJJdXkwaFNKNURMY3lnL0FsdkN2QThreTJGd0lW?=
 =?utf-8?B?N21VVjNZV005YlNSUHpJaGZqeGNEY3lQTU16a2Q5R1poV3NmejlCeGZ0TWpl?=
 =?utf-8?B?V3YydGNzNE0ya0o0UlZ6TUVRUzlKWmdPL3BoYmI2SGtWVUNCbnppWGtkeUhv?=
 =?utf-8?B?RktsTC9PT01LZGpCWG96dDV2WUdHSVg3eHFnNjVGVVBrdElTWDhuYUlWSnRw?=
 =?utf-8?B?L0tWMXEyS3NLeStiS0U0M0V5dUF0c000MHNjeFNmZWU1M0hPYzNhRzZyaHFJ?=
 =?utf-8?B?WVlOak9FcENoeTRjaXdKZTFQcDVpb3FObmlBS1JMY254SWxLSWVtVjZKUHRn?=
 =?utf-8?B?dStiVTMrd2VDOGJPdkgvWXdzRC81ZFBhVGlWd05xd1BrRitXV1J1NHkxb3RQ?=
 =?utf-8?B?MVZabWJXYThOWVhqNElueFN5Q0NPcmxqR3pPOXgvOE5lSVBmdlVoYVp5VC9j?=
 =?utf-8?B?cklmWDBwRVJZbW5vSXhjVklmSDdlWG1yaVZpcTVRaEVxTVpjY2FUR0FtZTM0?=
 =?utf-8?B?eTlUK2NFWkhzY1UwakdGdW1kL1RxRHFqT09vK0NJT0VjdUZ5WTR4STNXb3RU?=
 =?utf-8?B?TnlUWFdDZTgyQmJQczZ0YU5kNVNNZmo4eXRQMXUxMklnNWZWTWxYL01tVWdB?=
 =?utf-8?B?YkR2WmRlUWF1V3lyTDcwaW9KYy9ROGxYc1NIVjFRNU4rem1kZEpDSTFWcC9M?=
 =?utf-8?B?OTBzc2hvUzM3T2NSZ0ZnQ3QvNHcxbHlhb0J0aEhLK2p4MWExVWtUSEExNnR5?=
 =?utf-8?B?N3k2aXJ5bER0SC9RSkRQSWdKcHR3QTRGSXNjWW5vN3JLUmFlemxWc09Jb0c5?=
 =?utf-8?B?cU52Sk1FanRuVm1zSEpmRGZWcnAvNEVuSHhYTWhyU3E1Y3Zhbi9jbllyNEM0?=
 =?utf-8?B?eEhYNVpqRGVPZmxtSittTFpia1RxZFoyMCs5WDZTY2ZvcDg5VnNKUnduaC9x?=
 =?utf-8?B?SVhlMUg2L3B6ZDR6cTJOWjQ5QlYrU3FnWW9YWGRRd2lrSzFkazR4cHRJUGpS?=
 =?utf-8?B?N1NXc0pKa29DU1dlVFpaNDl5YkRZd2ZKL1JySHhNdHc3MzVZYzJua0IwaTBt?=
 =?utf-8?B?M2hxdEVUeXo0Si9iWDlsSTV1UUxyTFJsdEJFcTVnYlEyWFJsTFRnZlA1Zkl5?=
 =?utf-8?B?QjNkTUFXSWRvNlpqNG5kVjNuZ1JuLzhTdmUwMkFsclhQcmR0MlBhZE1VRUR4?=
 =?utf-8?B?aUhTNlR4Nk9Ld21NNyszKzMwYUhFbHByRG9oQ1NpQ3FKVnh2aUxjMzhLZ3lV?=
 =?utf-8?B?ZHliRjg1b2I3MEk1TXRLam0vT3UrTERhcWl2VzhMa2ZDcndQTUVQQVlSUndz?=
 =?utf-8?B?bjlWYjh3MldFRzNsY21nTE15NUtNWTdHQllqYUw4UUc0VnVUeUlFaTJRaU1I?=
 =?utf-8?B?amE5UFJoQnBqbEtydmZDa2tBR3k0TkFNempMS3J4SVdTeE05bXRkKzZJNjRy?=
 =?utf-8?B?T3VZZGdnYWdsMzduOEhjeDljaE9MZlVsb0RCVjJNKzNUZ210UXlJeUdDblQ1?=
 =?utf-8?Q?QZ+JaP/FVa9G2d6VzT7l+Qqfd?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY1PR21MB3870.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb1ad9c-91d5-478d-84cc-08de16593af3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 19:36:03.0095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: euYUOLLdf4P/e729JqCGH0zYn8nnPtoZEuZDun+sm/pLgqZwtwnqxQIyPPUn5P0gwfMUyuQwbAXOKW5QmLfosQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2014

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDI4LCAyMDI1IDEwOjMx
IEFNDQo+IFRvOiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBsaW51eC5taWNyb3NvZnQuY29tPjsg
bGludXgtDQo+IGh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBQYXVsIFJvc3N3
dXJtDQo+IDxwYXVscm9zQG1pY3Jvc29mdC5jb20+OyBEZXh1YW4gQ3VpIDxERUNVSUBtaWNyb3Nv
ZnQuY29tPjsgS1kgU3Jpbml2YXNhbg0KPiA8a3lzQG1pY3Jvc29mdC5jb20+OyB3ZWkubGl1QGtl
cm5lbC5vcmc7IGVkdW1hemV0QGdvb2dsZS5jb207DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGt1
YmFAa2VybmVsLm9yZzsgTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+Ow0KPiBzc2VuZ2Fy
QGxpbnV4Lm1pY3Jvc29mdC5jb207IGVybmlzQGxpbnV4Lm1pY3Jvc29mdC5jb207DQo+IGRpcGF5
YW5yb3lAbGludXgubWljcm9zb2Z0LmNvbTsgS29uc3RhbnRpbiBUYXJhbm92DQo+IDxrb3RhcmFu
b3ZAbWljcm9zb2Z0LmNvbT47IGhvcm1zQGtlcm5lbC5vcmc7DQo+IHNocmFkaGFndXB0YUBsaW51
eC5taWNyb3NvZnQuY29tOyBsZW9uQGtlcm5lbC5vcmc7IG1sZXZpdHNrQHJlZGhhdC5jb207DQo+
IHl1cnkubm9yb3ZAZ21haWwuY29tOyBTaGlyYXogU2FsZWVtIDxzaGlyYXpzYWxlZW1AbWljcm9z
b2Z0LmNvbT47DQo+IGFuZHJldytuZXRkZXZAbHVubi5jaDsgbGludXgtcmRtYUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRF
Uk5BTF0gUmU6IFtuZXQtbmV4dCwgdjNdIG5ldDogbWFuYTogU3VwcG9ydCBIVyBsaW5rIHN0YXRl
DQo+IGV2ZW50cw0KPiANCj4gT24gMTAvMjQvMjUgMzo0MSBBTSwgSGFpeWFuZyBaaGFuZyB3cm90
ZToNCj4gPiBAQCAtMzI0Myw2ICszMjc4LDggQEAgc3RhdGljIGludCBtYW5hX3Byb2JlX3BvcnQo
c3RydWN0IG1hbmFfY29udGV4dA0KPiAqYWMsIGludCBwb3J0X2lkeCwNCj4gPiAgCQlnb3RvIGZy
ZWVfaW5kaXI7DQo+ID4gIAl9DQo+ID4NCj4gPiArCW5ldGlmX2NhcnJpZXJfb24obmRldik7DQo+
IA0KPiBXaHkgaXMgIHRoZSBhYm92ZSBuZWVkZWQ/IEkgdGhvdWdodCBtYW5hX2xpbmtfc3RhdGVf
aGFuZGxlKCkgc2hvdWxkIGtpY2sNCj4gYW5kIHNldCB0aGUgY2FycmllciBvbiBhcyBuZWVkZWQ/
Pz8NCg0KVGhhbmtzIGZvciB0aGUgcXVlc3Rpb24gLS0gb3VyIE1BTkEgTklDIG9ubHkgc2VuZHMg
b3V0IHRoZSBsaW5rIHN0YXRlIGRvd24vdXAgDQptZXNzYWdlcyB3aGVuIG5lZWQgdG8gbGV0IHRo
ZSBWTSByZXJ1biBESENQIGNsaWVudCBhbmQgY2hhbmdlIElQIGFkZHJlc3MuLi4NCg0KU28sIEkg
bmVlZCB0byBhZGQgbmV0aWZfY2Fycmllcl9vbihuZGV2KSBpbiB0aGUgcHJvYmUoKSwgb3RoZXJ3
aXNlIHRoZSANCi9zeXMvY2xhc3MvbmV0L2V0aFgvb3BlcnN0YXRlIHdpbGwgcmVtYWluICJ1bmtu
b3duIiB1bnRpbCBpdCByZWNlaXZlcyB0aGUgDQpMaW5rIGRvd24vdXAgbWVzc2FnZXMgd2hpY2gg
ZG8gTk9UIGFsd2F5cyBoYXBwZW4uDQoNCkNjOiBAUGF1bCBSb3Nzd3VybQ0KDQotIEhhaXlhbmcN
Cg0K

