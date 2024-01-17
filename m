Return-Path: <linux-hyperv+bounces-1449-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F5682FF0B
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jan 2024 04:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B4A1C20FDA
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jan 2024 03:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5876117E9;
	Wed, 17 Jan 2024 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I4X1V1vG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80BAEBE
	for <linux-hyperv@vger.kernel.org>; Wed, 17 Jan 2024 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460401; cv=fail; b=lq75zmCs0vt8LL6eMEZRnHD474pLHL5ywehVJB5qOgUW83fZrjutB605N38eUppLK8QglxXgCM4nIA0M1LTAuqMytdaCzjF1nHzehC6u+7a7vFpXf1guMFHKMiG43dx6EKpyC14v8TD6f5601gunYVt9Zr3coTtp8hSf199HU8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460401; c=relaxed/simple;
	bh=MaXS9KbIbB1Cjhbx5fo2B1A52TmbkQR+Uh3SScCn244=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=jjRZSmBySUx0rnnusWfYXxb+F1DBvSYmo7EPtmw4cb1mWEq/syUjJooJWurrF1oht4YC6IYEpLjO/s13dA6wn9+x5o4o9dHrfPNpXQhpzknp0+VvUtLj4Wy60DvUXVUNdlMXIyvgHjKivf8AZib2l2cDRFDLbsLu8KSKfG2Psp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I4X1V1vG; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6DMRwRR19bAhoOximL2Z23rh2tAXM1BmXNh2tITDSXilunUXhr83lsrFe73R7gCix4CleBrIokEwubehLa0nUuHBg30c2SyRJoi+X26GZV3J0Aig/fs93vxvt3oc2LtThhwnRYfJFQrCp7/Nb746m29q3iLZGPG+K7wrSl7xaIkyD2m65WYNLcJhs9XJMqLZCxKEG3KpVkakn9/OFw4gQNjMl3Mhp0Clwo7D1SeBFdgej3lNe0o6Mmawj4r+ysvUii+3ARHv0rsRcbHaPxf/Jxfmp2Yx1jE95JQOU0mdNBgXgjuA/oJI1tRlG42cm9ur2lwhnqMIiHFkE3NHMgjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaXS9KbIbB1Cjhbx5fo2B1A52TmbkQR+Uh3SScCn244=;
 b=MJI9ifnKGdzmEL3pe0I5peNve7XGIRYS2pKHVk5Lpm66d7I1y2zr45pKWit6vMmh4vaJWS6XqTPA/m0o2N9foAwVHbqkT9BfokSN9Xy0ZJX//5ZpwxnhuCikxze615JbDCl1cUAxyrOJj/Yjwp59Arlci8sseo0IL/2h4U+PYS6dAF+Fd2fFAC2YAKwLB8PcaTxEopBxy7tt707IpeHRE9RMr+raJYGbzc7B9nUaJpPEEgofDiDecXi5IJjEck+bQs+rkCTgvDQa4oB/Vg22BlvQf4e0hBMstKqnF51B+CG6oIsp5LzKtOyctQVtDMIOtlRI5n7xMREDez/yIAQzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaXS9KbIbB1Cjhbx5fo2B1A52TmbkQR+Uh3SScCn244=;
 b=I4X1V1vGQy1SKR3zFtI26EK1oNA2QsUMT1n3Iwzr4SGssafpQRR21gzpKzZCiFociHPdyEs0E50uHOSfsNBLRXv6yyFiJf42pIoVtKlusaVqHZIg/ytZsMNruiG0bhnaBwYSgJrGoKk+odZSpeAsiY571tWCQ4IUPcc0ogqOK2E=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Wed, 17 Jan
 2024 02:59:55 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::2481:719a:5a7a:d6ad]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::2481:719a:5a7a:d6ad%3]) with mapi id 15.20.7181.022; Wed, 17 Jan 2024
 02:59:55 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: Wei Liu <wei.liu@kernel.org>
CC: Iouri Tarassov <iourit@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] drivers: hv: dxgkrnl: Allow user to specify CPU VA for
 device allocation
Thread-Topic: [PATCH] drivers: hv: dxgkrnl: Allow user to specify CPU VA for
 device allocation
Thread-Index: AQHaOHfVsT50vEVQWkagDWJ3H6w7ZbDclzywgADYf4CAAACgUA==
Date: Wed, 17 Jan 2024 02:59:55 +0000
Message-ID:
 <MW6PR12MB889841CC7947959A0A3AEC0FFB722@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20231227034950.1975922-1-Lang.Yu@amd.com>
 <MW6PR12MB88989AD3AA576FB36A023C33FB732@MW6PR12MB8898.namprd12.prod.outlook.com>
 <ZadBIxlwV_0KJ0oH@liuwe-devbox-debian-v2>
In-Reply-To: <ZadBIxlwV_0KJ0oH@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b5810e36-e744-4c6c-b20c-49a5631715c3;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-17T02:55:46Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|SA1PR12MB6775:EE_
x-ms-office365-filtering-correlation-id: aa7eafa3-5d7e-4208-c633-08dc17086223
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hDIEoBQuernwCUHPfYXD8uT+DNvB371ctn6S2bUeYMXYt9jrMhwjzLEsnZcsG2Nc0qRwj4r8UdoVyIJHziJi5C+k6jqkaIF7kw3z4a1GEA6xWqHA2ceVA6/p++0IQyTZKzw8G3jrmGptxkctXzISIp4TClVKC0nUE8R+iz/SNsImxmZ23C3PNF4d5vSRmnrJxRKlQmW5WU+z2JuRKAtEZ2mGT/syHA8L0Yl176O+iIuGdZnc+6Dmy19hdwy6kha31PAZsNYFQmQx3pHmfpgtw6wKbQ6oCprHzBEOeAOCH1jVsblOJjtmVKmUORwxWzgZZnYaE+fiR94RfI8XkUIDscIj+7NGrrv9xp7NRW903FsHXcM+kcfQuF0DdvrWX4Pd7vcjQsp/34rhvaTx7uB3ZP5kOYdw1jeMelrxZL5RhgfvL2RhGhIKp6Rac8JEr7OXWRW0DvPeBTPUzsCxURbuWTsa+DAHhdAeH1nyPtzYX30R/q010Qlb37BG9tWuSB/mnuukU1TH+9nyK8rlhIeuco1nHyrhEq3s3J4sH7SL5LP1KAGQJK85BFo1i3l4Ko46oQgX9+exO0eyDLK7FZ+OleKgZC8aon6srkOxUWabbyHs9aM3ppbBVTE0QGrI3tkN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8898.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6506007)(7696005)(55016003)(6916009)(38100700002)(66446008)(64756008)(83380400001)(38070700009)(26005)(41300700001)(45080400002)(76116006)(9686003)(71200400001)(66946007)(66476007)(478600001)(966005)(66556008)(316002)(8936002)(54906003)(8676002)(86362001)(52536014)(4326008)(122000001)(2906002)(5660300002)(33656002)(133343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aZ2iGFA4gBMogs+cIXmr2ZmEuxsCMpKWCawFmnkm4Uw05ENgXztGGedT4V7i?=
 =?us-ascii?Q?wd5zPCUTGFjGv9ypqzXRa1PuLhI3LLJIfLYOFywfbVwyf7sp1+l0Qi6UgwqZ?=
 =?us-ascii?Q?SvYCKfObHMyYkY9sd7woQFDE6BAwSScQo0wwKnBmAyspF0L7sA6Le0yQ3/0J?=
 =?us-ascii?Q?hDuZ2mozrMTFSTyVeuFTsthaDAfTNNkEhlU6juxKKy7ePL3TQYIHyS2x+F1E?=
 =?us-ascii?Q?Mv2sEar52Vq2vrnecXH19RFtl+I871/cO1LLZ9XnpDqKCVzARcLSav6Tvf/p?=
 =?us-ascii?Q?QfRhvQqgm+djX45FGfNLr00RLb7+gFVhJuTWILOrKOxvUXbjiZ4MmmAcDXa0?=
 =?us-ascii?Q?STFAQ2EJBH6Y7a7t9Aon0kFiO+1tEKkZ2nswotdaLA7VUIMlVEVL1KGwBqwz?=
 =?us-ascii?Q?7eFKpdc4vdtMzRDOo+VR7qbARAx18O7aK8gzwCgWgYHfpI09tbgMH4pOuPsu?=
 =?us-ascii?Q?p3K8M3OqrYeZFkpGpQbK0JAHg7WPFtWHWzIB71WDcAJAnkQuRmJ1fkqsFyaI?=
 =?us-ascii?Q?jFSvBYESK3rpMCM0Ibx4ivaJHUsfzVDcTr0lqc8YtnuiiJMv/1iPa9BQZ4HY?=
 =?us-ascii?Q?FY4tT6UQzFtHyN/Jd9iSeCVkQajd4btH89Aas7XRgUaApgoV7U3FHj0Yg8wO?=
 =?us-ascii?Q?SZ4YCSQGOnBbDchKs/HDYzLUq19ogHMdtiRWs8JxoqqjxWwc6UoKgHBfu4PI?=
 =?us-ascii?Q?ptMXRg1fZPxiZDjyrqkVOdaw2EP83cxyXU4C7cVW/reEFVhazfulA139Fkmx?=
 =?us-ascii?Q?YoAATyHT3BulgSU0FRgT25rs2pTj4g+/vSlLHa3PC4kZsK/co2l7P2OfBSre?=
 =?us-ascii?Q?wWBm7Zyp0dWMM8r957FQE8TKVnWzwh3UWng0BpfULWtIoQ3EOHNPxrJj3crc?=
 =?us-ascii?Q?DTT/r6PoVLALGF//vWtXled/obcjJifrIuoXUpzGpixOmBxyKjme98gffoa2?=
 =?us-ascii?Q?INqZckjZETHLchSLWQTSDaVUw5tRyEqzMyu6qFIDew+dY2X1i7N/EBTcDHgR?=
 =?us-ascii?Q?B6oU0FhlHeAF2RxwsqyLVlWj05SGTLW1QFy2RIw+J3I7aYqhSV6RB7GXgfpu?=
 =?us-ascii?Q?hxB2y2iQGV2k5JHI3xnpU9OK4BKHMTymKQ4+cVwqndvezIRv2HeiZJtTuTd5?=
 =?us-ascii?Q?Z4H3kpLwyQ2J9fAMZ/OmDqEj8vyBgx0AwW1uruMN6NvGVsymw7tbdO3O388G?=
 =?us-ascii?Q?1Yl1nc1SX/wCTIQR/mbejh8Pnoehv34bYv5u3+SFEn0kOR8vF763begdBCDN?=
 =?us-ascii?Q?psjlSPVQOWaxdIVUMxi8QPe7qPMmQ+i7JBtTqR3DQpjCW9+7JUPIQZ5AURZg?=
 =?us-ascii?Q?20IosxEllyu8DldN/ce2L7clDHJqDSVR35OJ2KXb/i26EEirQ2t4E//YOvtk?=
 =?us-ascii?Q?HoDTl2FvxYSzPXh9sjKeB9E/9HCDUrifdT1N+PLaXWoFuub9eG2YvUYtHRvW?=
 =?us-ascii?Q?Mr7z+8hAvCrBioMW98Y4jC6FX36vZsiNpE3M1rfPRmmnglzZ1xW04As6LaNd?=
 =?us-ascii?Q?yEh6k7Jr5N18NzZ7l+ANLL6UkSXV6JFPkTP//agHKgLRcYFw6cJ83Rb3NjJI?=
 =?us-ascii?Q?dcKjQHUL0qr2YHL1Kgg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7eafa3-5d7e-4208-c633-08dc17086223
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 02:59:55.3020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqnyKNfHvyeFYDVGzOku+T2h6yAwD6b8QY9mSUzKvmO4pLNT61z+ckC9fEL1ceET/WQ8z0cInr8pEB1zw/jGZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775

[Public]

>-----Original Message-----
>From: Wei Liu <wei.liu@kernel.org>
>Sent: Wednesday, January 17, 2024 10:53 AM
>To: Yu, Lang <Lang.Yu@amd.com>
>Cc: Iouri Tarassov <iourit@linux.microsoft.com>; linux-hyperv@vger.kernel.=
org;
>Wei Liu <wei.liu@kernel.org>
>Subject: Re: [PATCH] drivers: hv: dxgkrnl: Allow user to specify CPU VA fo=
r device
>allocation
>
>On Tue, Jan 16, 2024 at 01:58:53PM +0000, Yu, Lang wrote:
>> [Public]
>>
>> ping
>>
>> >-----Original Message-----
>> >From: Yu, Lang <Lang.Yu@amd.com>
>> >Sent: Wednesday, December 27, 2023 11:50 AM
>> >To: Iouri Tarassov <iourit@linux.microsoft.com>
>> >Cc: linux-hyperv@vger.kernel.org; Yu, Lang <Lang.Yu@amd.com>
>> >Subject: [PATCH] drivers: hv: dxgkrnl: Allow user to specify CPU VA
>> >for device allocation
>> >
>> >The movtivation is we want to unify CPU VA and GPU VA.
>> >
>> >Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>
>Hi Lang,
>
>The driver is not merged upstream. I won't take any further action here be=
cause
>there is nothing I can do. Perhaps you can work directly with Iouri to mer=
ge the
>change to the driver he maintains.

Thanks. Got it.
https://github.com/microsoft/WSL2-Linux-Kernel?tab=3Dreadme-ov-file#feature=
-requests tells me submitting the change upstream.

Regards,
Lang

>Thanks,
>Wei.

