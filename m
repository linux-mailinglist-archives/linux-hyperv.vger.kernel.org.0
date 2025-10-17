Return-Path: <linux-hyperv+bounces-7252-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A4CBEB285
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 20:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6A41AE1FF7
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEA330CDA5;
	Fri, 17 Oct 2025 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IG2UQMZR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010021.outbound.protection.outlook.com [52.103.23.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B3529D28A;
	Fri, 17 Oct 2025 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724586; cv=fail; b=u2L2a3SsAbcBZUckjPGK+nJKJks6zgOvH0o5aCJO9LaRgZf+LypgjSGDby59EEMXpn+Ceglbh4Al5nxzd8Et/gWDXeU7meWv9ZkqjEV32j4/i93n5L1xDpJYawTAMR+yJ40oWvFaf9fNSbk42jlfA022PaZ4VlGOAokx4ozFTp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724586; c=relaxed/simple;
	bh=QgQ/h/bXV6QatPObsjU8Ktiwt8Voppl9ExSULmT/GFA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MjCnVWT0Oczxiq3jc5NiCSb+RQe6ZNc0B8G+QgS6pyHCkt//CMYwhuoQUeDIZutaQaRs+EDv0FDkuOxRiRshFf+NKryihZ19AfjA53PlPZ8CO5VxG5pO+oE8m+OnlswLn8sSU1RnNxyocC4vGm/zNm0hRbm9MiSFW6LdFJcaKMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IG2UQMZR; arc=fail smtp.client-ip=52.103.23.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNgSJQN/aNbQAu3KVi/++NYFHrMhEoR2qSlUzs5vc2Vy6xLpHIr7tNb09L5WK3ifolQ+q9N4sVGtTRn+JGLiRzezXKUc5SqDjYazIPuhKDhmjDqL60JSd39z2IA8H1FMsxy8w+acZjTkaECOcYa+hrI4qPmwfOf9hyNZjWugm7azSrJNlVx94mOPDcSJPk7KWeXvaqNzzCFrZ2Q7XhaJRY1PX7QrXZom1JR5TUFf5KAeGnebHOn/eRfyyb04KeiJA82wKAf/Bad0iaNPZ6iMCOs/6J1FiZ9AkRTs++HKjhEzsDp4vm0x2RUXG+VMS0zwAav0IjooohpT6x9pE9nGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgQ/h/bXV6QatPObsjU8Ktiwt8Voppl9ExSULmT/GFA=;
 b=wVhVf8Fccx4kC1zeUS0VgW8pU9m/4P7hPESkQQMIa3UIFSqFm7RxZNZ4x4jSkNb2Ok3vt5mLFzjlzJd5QKN2wnd8Hd4q0PtTTxWipeDUY+l8z+4zgC+2TQ7SVZAof8ScjI29prSMndkve7PxjIKaAwdt3lXz5Y5a/dv4/fLhygrcKT2dQGc2WbUI3IJ7uIwSxuCaBaLVdxsbZ5VRmZLLMUq7kKQxMRzTnM5uMhTp0r7dFPEf6zxUSs9ro6hFwZfyDpSjWaagcUT75yBRgD03zskv2Sqm/rznXNQC9Bobrvtz/xNgF2NtHuUf/egrGkMuL3xygR6+vAppvLoHiUe36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgQ/h/bXV6QatPObsjU8Ktiwt8Voppl9ExSULmT/GFA=;
 b=IG2UQMZRwUwJYhEmK6qhye0JerFKcJtu530qC7onQRNNWxOv/nFlL+r+G6Kr/jtK70U649iF+sG+Wi+OGUHsu94JQ4d1zVnHL4Uf3r6SPIoalWyKJhvwazso92UmGWNlCN9IHlroUQ+jsw3g8uAyJZ9dqhjOHYfjAd/LgVdqVM5P2JX6p52HPgMEQyZ3sswd/ZAlFTR9MqWfKv1Kf+I196bJQqLpFqLyOITVZfAXXq+9EXXUJ2IE6lAgbLoohdzIlh8XXSzTehstsMH/vYM1cOergY2n0HrBp3v3Jz7g0LEACx/lZE17ljpY17j8O0q4z73/JnWj8Tgf8hLS233Nyg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6647.namprd02.prod.outlook.com (2603:10b6:610:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 18:09:43 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 18:09:43 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
Subject: RE: [PATCH] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
Thread-Topic: [PATCH] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
Thread-Index: AQHcPtae4hOlmQ8RLke3rh0l8QIZ4rTFhImggAET5oCAAAFWcIAABvSAgAADwIA=
Date: Fri, 17 Oct 2025 18:09:42 +0000
Message-ID:
 <SN6PR02MB4157F402AB89602C08A6109FD4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1760644436-19937-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157E6D02773A9D7A4B9E85BD4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <a0090bbf-08b4-4b36-8cf2-18687a83ee8f@linux.microsoft.com>
 <SN6PR02MB4157EE75A14F5F7EA7D6D070D4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <1d5a7098-dcbd-4a0c-aa6c-481f131b1491@linux.microsoft.com>
In-Reply-To: <1d5a7098-dcbd-4a0c-aa6c-481f131b1491@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6647:EE_
x-ms-office365-filtering-correlation-id: 65fa60bb-74db-42c9-e065-08de0da858d8
x-ms-exchange-slblob-mailprops:
 ScCmN3RHayF0bP0FcI6aESyZnZAIXMvqjFwUcQUbKcBzF0ergSxPXZzlFNCHeo8DIlKSflva+/XKicEn07hV9EcSV+r7xCukau6lrHrTkuswYD10gktHbouDdOesuWy+yDPvkpUuOprIQRQP/5UuIC1/+dK2p7DtKcvhxQFubeG7ReZhD7eAi+vk0tqTJblrwWEnklPeYa/NKkQ8PDo5VOCGNqA4xaMQNq3u39+5Br/WEDASb41bSqNb8lOf1IdbbZGSoUY6PuGcL07xWY4ToWJWK+Q7jO+Q6z612oIYi4padAYfVMymOYVZztf+jrjW5nfo7KN8jAslElc0LQF2hieDvamINw22YnVny4SC2B/MU4qe8aF6+KRUzxEdbNmKsnGDx+TYRXivS2Zjz6dsrEq4uRfP2wGZ/7BYsgzaaEdkP7rzIQUIBo/13zoq2NyCzQwO4Ig1vj9Fphfb94SOvHQ8/YvA36n52Ld0jClmtDyI2QB7O1VWSGYr8jR2XneWsFVHDmAxQZNlpfNwRucFRpGh+VT5HZhTKasQwSePCuFDQSYJdRdL13vaI+uxDmDaHtXI3V0vM+YbZXbOs17oF2iUuIQrReGtFbiirYC486yi8TkNBEVlwjX/Tkxz4dC9KDAQ9ugrJYQEXUGA+iFRFM8MdmO50wHa11rXVfWCUk8SJTrD1zKYRvSqiBJoD4McLJnyusnuS7zEkv0Z8MPK9ZMAYBnFt8XozzkLgwM2K5w=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|31061999003|12121999013|8060799015|8062599012|15080799012|11091999009|19110799012|13091999003|40105399003|440099028|3412199025|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?TEFZbGduN0xMaE92ZWpOd00rWUw3OC9NbjBsRXpmaEliQUgvV0FsM1BkZFg4?=
 =?utf-8?B?MTk5ajJPTjV4TzJONmY2ZUVENWRIU1VRRVF1Wnc1dGRoR2FWMmlIajRxNTVn?=
 =?utf-8?B?SkxYaXdSbjIrZ1BZWTJVTmlva2pWRHVvMENkOU8waTl2OE9ZWGJMcUZMU2cy?=
 =?utf-8?B?ZVRCbTRtQjkrN2svTHFGMnJ0VTlQdUZYUVVMc0dPa1dPLzNWOG44TjlzZUhm?=
 =?utf-8?B?VG9pcnRxNXEyZ2FKVFphaVlielNKYWl6SlR4TTZUS29hTGUzVjZlelN2MG9J?=
 =?utf-8?B?MXBXUFlGNGg2YUZlRUQrMThOYVNmdCt3U3phZDJFdURCSnlmbXFIaVhzKzRS?=
 =?utf-8?B?MzRhdUhsV3VJUnM2U05STGhoNmk5N2I2b0NHQ3hya3AzVHl4T21TSHZ0K2lV?=
 =?utf-8?B?aGlmaUxPamtDWUhRckZDT0lTZXZFWTNwb0IvRGttTjJzU0VRZzd3ZExQZHVm?=
 =?utf-8?B?cjY5RHpkaVV1cmNmZDBrQnJpbFE0OTNEWHZUK3NzN2QvT1d6YktWVzE0dGVw?=
 =?utf-8?B?WWV4cmxRVk5CeTNmeVFMQk93cjNPakNqUGFvU2RBM0I3N3doQ2ZCTTRYWW9m?=
 =?utf-8?B?TDdXMzlHSUh0bGpGeTJKZ2lNcEkwQ0hscnFBblBPSGlueHJKT0VHbHJBcmh4?=
 =?utf-8?B?NndhR0pIN0xIeTI0d2NqVzlDdEYwUDNEd2NScnJNQTVOOVdRd0FjejZRSTZk?=
 =?utf-8?B?VXY4dm1zNFdFZGFabXlyY1ZWdWNVNjlwT3FKRWxsbzA0UmlkUTBZSm0vN2FL?=
 =?utf-8?B?VHdpWlNpbWpyclNBd3hnRzZMUHhLY3NnZS81Rlo3RTUrTDd6VEpZM2Y3OHlh?=
 =?utf-8?B?NURiMzBqbDZZMmtmU1FhOWhLUjIwL0Q1U0x0V01YQWV3RWsrb0xjZW1Ob3pl?=
 =?utf-8?B?ZGt5TGhwWDFiSkpoZlN3ak5xVUdTaFlZSU9xQmx4VzV2R0k2KzQ0NVdYRjVp?=
 =?utf-8?B?ak9laVpFRG9QOVdaMFlnMGRaSytQak15TG1iSmJqQklsNmtQVzZYZjNPS1FQ?=
 =?utf-8?B?QkhENjlCd1Q4bE5sQzZHeGhHdS9sNU04L0JQVENlRVVJQ2tWUlJhd29UYmVW?=
 =?utf-8?B?eGV2bEp3ZDdoZUZPRnhYVWFlUVVTU0ZIVEtzckx2cjJaN2dodTRrZGR6R2Vu?=
 =?utf-8?B?MXFXRy8yd2xrN2doUTVBSDNMeG1tVG5VRVVEei9lZVNLZFBIMEt4RWJHNWtO?=
 =?utf-8?B?U0Z2Q3RCbTcvOGc1N0ppeFdpL1YrVjBJNkxXWVdrZFYzWTFRdStQcU90V1pz?=
 =?utf-8?B?czlMMVI1MXdwNzNiNlJFeHBXaW03SGd3TnFJcEVlMi9WSTRXb00yeVM5NW56?=
 =?utf-8?B?RnUxUlpqUU1lSGtrOXcyK0hjU1kvN3hwWnk0YW5LakVXVVY3VkR5dkFwZGgz?=
 =?utf-8?B?cnUyeTF4WmdBdG14YmlSZHhrSHFHUUlOb284M29TSTFEMGJJQjd1M3RUL0gy?=
 =?utf-8?B?T2FoQXVaMFlES2dsN0VtdUx6dlpSOGpld0I2eEo2blJaM3dDWXBTSDFuWTRx?=
 =?utf-8?B?TGhLY2NkNWhPRkRraTZUbEFQcEMwVzlGK3h1emxmYzN4UlM2YW9SWHdPcVNE?=
 =?utf-8?B?MmpDM25TanNjSnVCcGd4YnJRajdwTlVBNFVCVTN5enZoS2hMTW9EU3RJQ0Rn?=
 =?utf-8?B?WnhGa2t0dWVBQlluUFdCR1lhV0VFelhYd1loZnpDOHBJcGJKYkNhOEN6bUw3?=
 =?utf-8?B?YzFZM2Y0c1EvVzVlWFQvazUxY3RIZDhzbm9UYjd3dS9LdlFTcXhqeFdnPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUNtd1hLNFk4SkxRMWxTdkFyd0k4VXlyeE9EbStseHEwcEx6VnA0WmVoOGdo?=
 =?utf-8?B?Vjh6c2NkSE5SUEg0WW50c1ExM3NIb29xRDlxSWdJWVkyNko4N3JCMU5rT3Rv?=
 =?utf-8?B?VjZsWWFrUHQwWHF2MjJMME1EOHZtbkdTQ2dkUUZtczJrMk5VeTVhQ1IvQmdn?=
 =?utf-8?B?QWJNK0s4WnJOczEybnNudHBtWDZTTWFYa1lDVzVkd25nWThuYy9yTTJwM2x1?=
 =?utf-8?B?d0FwWXN5ZDF0R1NDdHVIeHlFTnI0Vk9hVGl2YWRHZklpeStMbGlYTjlUY0RV?=
 =?utf-8?B?RTlOWDU4Qy9vSkxLQi9XMVBVMm9oZjczaWU1S05sbFI2VlNPTzNIcVV3V1Uy?=
 =?utf-8?B?NTlDZW95SjdJUzZlOERjMlFrNUp4TllldFZGRmZTenVQb25YUDRsU2sxSnJG?=
 =?utf-8?B?TFQ4VFN1NFQrQVFFcUpRSXkyTi9PRUgxbUs5YjhDZ01BbFJ2b01LNm1zdmV1?=
 =?utf-8?B?M3dnbEUvY2kvZXUxNmcvUTFIUlNqUGw1R2UrYlZrUUY0R3M0ZUxHbWR2U0hj?=
 =?utf-8?B?S201eis0SFRPQ3l4L3dDcUZCM3ZqbWltcUx6QUlBeHl4MHp5MXN6OE03bEwy?=
 =?utf-8?B?U2IzWFlKVnFtaGRLVmt0Rm0wMXRXRkRFUjEyOGgreXY1T0RpVHY1eHRRS0J1?=
 =?utf-8?B?OWc4NUthU2NzcHVIV3RQVkhaNURYTkFkaFc5YTQyUXNtSDJTb1N0ay9vdG53?=
 =?utf-8?B?WFRzL3QzQTc3U205WmFYTi93ekZFQkFRdHBSOUxkSEUwODNVTXFOYlYrS0Yz?=
 =?utf-8?B?THVyamdzU2N5YjRzZlNta2lqUXdFMVltYXBGNGszdlZhTlFsSVJUaEl6Umg2?=
 =?utf-8?B?L0Q5cWpYM1JDVStMcXlYU1J2Z01pNHoxalJDc0FacVNzY3BTbGVUUVJCYnFH?=
 =?utf-8?B?a0tKVTc2TllkNkNZTEk2TjRxejNNK0tGRnhTVk9XbU9iaU8rUTM0VUFYV1ZF?=
 =?utf-8?B?MytRM1lBWXNJNzk3Y3ViWHZ1ZG1aNFNIUlQyV1BHVUhOQUo0UjRETjZ0L21T?=
 =?utf-8?B?Tm5IUmNETFdzWTJGTkViaE52V3V4K0FxWWVHSE9iamRCMEV4aHMrZ2tTNmNU?=
 =?utf-8?B?dG9sZjUya0hMR3ZSWHl5eDJnN0VzTndsQTIvOERNK2JocERUVUd6ZXgzQzhR?=
 =?utf-8?B?M0U5VlhGTkFLVVdqSWRsbndOREg3NTFldk5iTTYzbFZTVm1IY1dWMkVPaFRH?=
 =?utf-8?B?WTJMYnU0UVFuMnVsL2dlWDQ0c0xzbEJ4UGNQOUpEaDZvL29GUEhZQTBERldX?=
 =?utf-8?B?aG9aeWxDb3REWU90emZpS3hhZTA5UmVkQllmaUh2RjhxUTFuM0hDR0NkL2lK?=
 =?utf-8?B?VGtOcGc3aEs4YmhIaTVNRElEaDBtY29pNnJpNXZUc3pEbzYvTVI2TklIN3Bk?=
 =?utf-8?B?QUNxdVNwVmhVOEdiaTJWWHZDQ3NOZnFTNlhIT3Fua1JuSWtYZGxVN1d2SEJZ?=
 =?utf-8?B?cVAwTUt4L2I5OEdrVW9hejNsb01Jdm1iMHk4am55WlVyZDgwL3haanNYWjZZ?=
 =?utf-8?B?YWtEOTlGbXduSDhSZVpGMXEzdnVkazV3aitLajFpUmlPalhFWVpLNlN6R2xI?=
 =?utf-8?B?NkM3VVdqcExxTVJmQU1tclZKLzh3U2F6UGgraERqMmFDcE9wM1JFbUhVOTdu?=
 =?utf-8?Q?00KEdUkajvAVoNn6g5I9432yGnjHBWDQH6UGXC6QtxM8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fa60bb-74db-42c9-e065-08de0da858d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 18:09:42.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6647

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBGcmlkYXksIE9jdG9iZXIgMTcsIDIwMjUgMTA6NTUgQU0NCj4gDQo+IE9uIDEwLzE3LzIw
MjUgMTA6MzMgQU0sIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IE51bm8gRGFzIE5l
dmVzIDxudW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogRnJpZGF5LCBPY3Rv
YmVyIDE3LCAyMDI1IDEwOjI2IEFNDQo+ID4+DQo+ID4+IE9uIDEwLzE2LzIwMjUgNjoxMiBQTSwg
TWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4+PiBGcm9tOiBOdW5vIERhcyBOZXZlcyA8bnVub2Rh
c25ldmVzQGxpbnV4Lm1pY3Jvc29mdC5jb20+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE2LCAy
MDI1IDEyOjU0IFBNDQo+ID4+Pj4NCj4gPj4+PiBXaGVuIHRoZSBNU0hWX1JPT1RfSFZDQUxMIGlv
Y3RsIGlzIGV4ZWN1dGluZyBhIGh5cGVyY2FsbCwgYW5kIGdldHMNCj4gPj4+PiBIVl9TVEFUVVNf
SU5TVUZGSUNJRU5UX01FTU9SWSwgaXQgZGVwb3NpdHMgbWVtb3J5IGFuZCB0aGVuIHJldHVybnMN
Cj4gPj4+PiAtRUFHQUlOIHRvIHVzZXJzcGFjZS4NCj4gPj4+Pg0KPiA+Pj4+IEhvd2V2ZXIsIGl0
J3MgbXVjaCBlYXNpZXIgYW5kIGVmZmljaWVudCBpZiB0aGUgZHJpdmVyIHNpbXBseSBkZXBvc2l0
cw0KPiA+Pj4+IG1lbW9yeSBvbiBkZW1hbmQgYW5kIGltbWVkaWF0ZWx5IHJldHJpZXMgdGhlIGh5
cGVyY2FsbCBhcyBpcyBkb25lIHdpdGgNCj4gPj4+PiBhbGwgdGhlIG90aGVyIGh5cGVyY2FsbCBo
ZWxwZXIgZnVuY3Rpb25zLg0KPiA+Pj4+DQo+ID4+Pj4gQnV0IHVubGlrZSB0aG9zZSwgaW4gTVNI
Vl9ST09UX0hWQ0FMTCB0aGUgaW5wdXQgaXMgb3BhcXVlIHRvIHRoZQ0KPiA+Pj4+IGtlcm5lbC4g
VGhpcyBpcyBwcm9ibGVtYXRpYyBmb3IgcmVwIGh5cGVyY2FsbHMsIGJlY2F1c2UgdGhlIG5leHQg
cGFydA0KPiA+Pj4+IG9mIHRoZSBpbnB1dCBsaXN0IGNhbid0IGJlIGNvcGllZCBvbiBlYWNoIGxv
b3AgYWZ0ZXIgZGVwb3NpdGluZyBwYWdlcw0KPiA+Pj4+ICh0aGlzIHdhcyB0aGUgb3JpZ2luYWwg
cmVhc29uIGZvciByZXR1cm5pbmcgLUVBR0FJTiBpbiB0aGlzIGNhc2UpLg0KPiA+Pj4+DQo+ID4+
Pj4gSW50cm9kdWNlIGh2X2RvX3JlcF9oeXBlcmNhbGxfZXgoKSwgd2hpY2ggYWRkcyBhICdyZXBf
c3RhcnQnDQo+ID4+Pj4gcGFyYW1ldGVyLiBUaGlzIHNvbHZlcyB0aGUgaXNzdWUsIGFsbG93aW5n
IHRoZSBkZXBvc2l0IGxvb3AgaW4NCj4gPj4+PiBNU0hWX1JPT1RfSFZDQUxMIHRvIHJlc3RhcnQg
YSByZXAgaHlwZXJjYWxsIGFmdGVyIGRlcG9zaXRpbmcgcGFnZXMNCj4gPj4+PiBwYXJ0d2F5IHRo
cm91Z2guDQo+ID4+Pg0KPiA+Pj4gPkZyb20gcmVhZGluZyB0aGUgYWJvdmUsIEknbSBwcmV0dHkg
c3VyZSB0aGlzIGNvZGUgY2hhbmdlIGlzIGFuDQo+ID4+PiBvcHRpbWl6YXRpb24gdGhhdCBsZXRz
IHVzZXIgc3BhY2UgYXZvaWQgaGF2aW5nIHRvIGRlYWwgd2l0aCB0aGUNCj4gPj4+IC1FQUdBSU4g
cmVzdWx0IGJ5IHJlc3VibWl0dGluZyB0aGUgaW9jdGwgd2l0aCBhIGRpZmZlcmVudA0KPiA+Pj4g
c3RhcnRpbmcgcG9pbnQgZm9yIGEgcmVwIGh5cGVyY2FsbC4gQXMgc3VjaCwgSSdkIHN1Z2dlc3Qg
dGhlIHBhdGNoDQo+ID4+PiB0aXRsZSBzaG91bGQgYmUgIkltcHJvdmUgZGVwb3NpdCBtZW1vcnkg
Li4uLiIgKG9yIHNvbWV0aGluZyBzaW1pbGFyKS4NCj4gPj4+IFRoZSB3b3JkICJGaXgiIG1ha2Vz
IGl0IHNvdW5kIGxpa2UgYSBidWcgZml4Lg0KPiA+Pj4NCj4gPj4+IE9yIGlzIHVzZXIgc3BhY2Ug
Y29kZSBjdXJyZW50bHkgZmF1bHR5IGluIGl0cyBoYW5kbGluZyBvZiAtRUFHQUlOLCBhbmQNCj4g
Pj4+IHRoaXMgcmVhbGx5IGlzIGFuIGluZGlyZWN0IGJ1ZyBmaXggdG8gbWFrZSB0aGluZ3Mgd29y
az8gSWYgc28sIGRvIHlvdQ0KPiA+Pj4gd2FudCBhIEZpeGVzOiB0YWcgc28gdGhlIGNoYW5nZSBp
cyBiYWNrcG9ydGVkPw0KPiA+Pj4NCj4gPj4NCj4gPj4gSXQncyB0aGUgbGF0dGVyIGNhc2UsIHVz
ZXJzcGFjZSBkb2Vzbid0IGhhbmRsZSBpdCBjb3JyZWN0bHksIHNvIEkNCj4gPj4gY29uc2lkZXIg
aXQgYSBmaXggbW9yZSB0aGFuIGp1c3QgYW4gaW1wcm92ZW1lbnQuDQo+ID4NCj4gPiBPSywgdGhh
bmtzLiBZb3UgbWlnaHQgd2FudCB0byB0d2VhayB0aGUgY29tbWl0IG1lc3NhZ2UgYSBiaXQNCj4g
PiB0byBjbGFyaWZ5IHRoYXQgdGhpcyByZWFsbHkgaXMgYSBidWcgZml4IGFuZCB3aHkuIEkgd2Fz
IGxlYW5pbmcNCj4gPiB0b3dhcmQgdGhlIHdyb25nIGNvbmNsdXNpb24gYmFzZWQgb24gdGhlIGN1
cnJlbnQgY29tbWl0DQo+ID4gbWVzc2FnZS4NCj4gPg0KPiANCj4gSXMgdGhpcyBjbGVhcmVyPw0K
PiANCj4gIg0KPiBtc2h2OiBGaXggZGVwb3NpdCBtZW1vcnkgaW4gTVNIVl9ST09UX0hWQ0FMTA0K
PiANCj4gV2hlbiB0aGUgTVNIVl9ST09UX0hWQ0FMTCBpb2N0bCBpcyBleGVjdXRpbmcgYSBoeXBl
cmNhbGwsIGFuZCBnZXRzDQo+IEhWX1NUQVRVU19JTlNVRkZJQ0lFTlRfTUVNT1JZLCBpdCBkZXBv
c2l0cyBtZW1vcnkgYW5kIHRoZW4gcmV0dXJucw0KPiAtRUFHQUlOIHRvIHVzZXJzcGFjZS4gVGhl
IGV4cGVjdGF0aW9uIGlzIHRoYXQgdGhlIFZNTSB3aWxsIHJldHJ5Lg0KPiANCj4gSG93ZXZlciwg
c29tZSBWTU0gY29kZSBpbiB0aGUgd2lsZCBkb2Vzbid0IGRvIHRoaXMgYW5kIHNpbXBseSBmYWls
cy4NCj4gUmF0aGVyIHRoYW4gZm9yY2UgdGhlIFZNTSB0byByZXRyeSwgY2hhbmdlIHRoZSBpb2N0
bCB0byBkZXBvc2l0DQo+IG1lbW9yeSBvbiBkZW1hbmQgYW5kIGltbWVkaWF0ZWx5IHJldHJ5IHRo
ZSBoeXBlcmNhbGwgYXMgaXMgZG9uZSB3aXRoDQo+IGFsbCB0aGUgb3RoZXIgaHlwZXJjYWxsIGhl
bHBlciBmdW5jdGlvbnMuDQo+IA0KPiBJbiBhZGRpdGlvbiB0byBtYWtpbmcgdGhlIGlvY3RsIGVh
c2llciB0byB1c2UsIHJlbW92aW5nIHRoZSBuZWVkIGZvcg0KPiBtdWx0aXBsZSBzeXNjYWxscyBp
bXByb3ZlcyBwZXJmb3JtYW5jZS4NCj4gDQo+IFRoZXJlIGlzIGEgY29tcGxpY2F0aW9uOiB1bmxp
a2UgdGhlIG90aGVyIGh5cGVyY2FsbCBoZWxwZXIgZnVuY3Rpb25zLA0KPiBpbiBNU0hWX1JPT1Rf
SFZDQUxMIHRoZSBpbnB1dCBpcyBvcGFxdWUgdG8gdGhlIGtlcm5lbC4gVGhpcyBpcw0KPiBwcm9i
bGVtYXRpYyBmb3IgcmVwIGh5cGVyY2FsbHMsIGJlY2F1c2UgdGhlIG5leHQgcGFydCBvZiB0aGUg
aW5wdXQNCj4gbGlzdCBjYW4ndCBiZSBjb3BpZWQgb24gZWFjaCBsb29wIGFmdGVyIGRlcG9zaXRp
bmcgcGFnZXMgKHRoaXMgd2FzDQo+IHRoZSBvcmlnaW5hbCByZWFzb24gZm9yIHJldHVybmluZyAt
RUFHQUlOIGluIHRoaXMgY2FzZSkuDQo+IA0KPiBJbnRyb2R1Y2UgaHZfZG9fcmVwX2h5cGVyY2Fs
bF9leCgpLCB3aGljaCBhZGRzIGEgJ3JlcF9zdGFydCcNCj4gcGFyYW1ldGVyLiBUaGlzIHNvbHZl
cyB0aGUgaXNzdWUsIGFsbG93aW5nIHRoZSBkZXBvc2l0IGxvb3AgaW4NCj4gTVNIVl9ST09UX0hW
Q0FMTCB0byByZXN0YXJ0IGEgcmVwIGh5cGVyY2FsbCBhZnRlciBkZXBvc2l0aW5nIHBhZ2VzDQo+
IHBhcnR3YXkgdGhyb3VnaC4NCg0KWWVzLCB0aGF0IHdvcmtzIGZvciBtZS4gIFRoYW5rcy4NCg0K
TWljaGFlbA0K

