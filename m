Return-Path: <linux-hyperv+bounces-11035-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JJdFT/GDGp2lwUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11035-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:21:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C83B4584990
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD7FF30120DF
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 20:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6EB3B38BD;
	Tue, 19 May 2026 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="taccab7a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010004.outbound.protection.outlook.com [52.103.13.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A62E7F2C;
	Tue, 19 May 2026 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222077; cv=fail; b=dt462HURhppAMJ6vMxuZ5f+ONFUGIlcMrEP5GoLnbDMdN3VHZPuyWGG0tEBf5iSewC4WheyORz5JB1bpK0B2fc6d9NWB0wTeF4+oQZmjUtVveVtOa3pPZY1B5d9bteCf7TlzJm8aa3jC3nHku8uhU7D7qckfztKI649QAnhCQwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222077; c=relaxed/simple;
	bh=PTtgII0DZ6lpmDnscjuh0yIQz5axCEKfwsr4Zt+xIwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RgEUzown+xmjgV3+Oz6jd8mARJ09j4AR4GLAuB8q9iLNowkNoQyYh+afGGqXupnv1O5FnnQ9raoc1tRteF4X60egN7iKZLArs9zTQV8rrpjxb/SeQ5XXKHU/kMBb0O+xB2+tC1zJPm5uwppLVmBNymy5xmeqW671rxMSXyF8CO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=taccab7a; arc=fail smtp.client-ip=52.103.13.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5l1wNVBjUXGqIR3S1pfdfpnmBEcIXmTuEa8UF7osiiw21ch1UYWMQxKhtyJffJrEfA9O+6VLsPz6EXSWe9fZFQo26ONMsVBjhEiImBvJClXVb26Ys1+2tLpKPHQYU/JHQQXHuvsFE7xv0z4QG5wMY6idZ1gvT2p7kWyojA6UlxUgKLnpcwLySpTxCbzj3INrzrR5aVrGeUIUPqo+dVLUzwnQ4W7O0h5mXM+ua/j4aIz6lAT56h0gtRp4iwZ9c2nEZXbD8cMLGZ7u0CMF35ZbU72lHEQ2fSHNEi6RduZaiewkC5fdnuRtxbzN9cOmv4ovEYnobIjRTufpZ89DkXk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTtgII0DZ6lpmDnscjuh0yIQz5axCEKfwsr4Zt+xIwQ=;
 b=foz1BV3MTj4/rxrFUdXOx+e3MCClgfHzFKXZNNYWcimhMkwdJmDP+MVxeU8E114p1JtC5aFuH3AQ763pb9FU5Urc3Bj9jY0JGgdSdCghSk7PNZjOin2ODRMWaq2s8FHlA1CZi0wh4InGxh+0yupmk9NYxGbAW38xhknQYlsy7AX/6lRsdEc7sG9eAWX1pqJYoIdFjQTV8TcPqgBAGS0xToNhfN2IUGWKkdPzydbQVefmhEMyxIBc5XxUVjNfFS9zukXPpYhJTFeetiGG8B/2cpd0dI3wU7QtPs3ZU1ZyV62cymoY5Ty/VOV4N8eYUQSShBR6cRMfJmR3iU7GADnD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTtgII0DZ6lpmDnscjuh0yIQz5axCEKfwsr4Zt+xIwQ=;
 b=taccab7aSkDNU91gbO5gkBlT1tp+6yCpN0yT45Wr9dxaXbo9u5Vl57t65UBM57D4f9YZJxopfTC1mvQMnIkkIg5tH2X1oErSPx8cCOIarDT2JAV/JZpkdj8e/V4/YZU/wR1/XCcjWMRMR82wQ8NWgDVy/As3ahRUqWrPCWfJL+clMEDhXTlB4GCahiYFYjIcHjpU804xetNcwjtkec4tZ5yn5ImReUq3vLTJU7W1GEzIyWeqUBNLi4AobchP6Tq7JRI4BsqbxEPxqKZR15PMOX6zqhXEchs6SoTqr/xPJN+tgkzQU4L8mypm1H+nXxoPk9Igf1Kgh31MJJEiFwVR4w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8514.namprd02.prod.outlook.com (2603:10b6:a03:3f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 20:21:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 20:21:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 16/18] mshv: Validate scheduler message bounds from
 hypervisor
Thread-Topic: [PATCH v4 16/18] mshv: Validate scheduler message bounds from
 hypervisor
Thread-Index: AQKgEqxJw6vunjXZ4JfDTdDBDzr/OQDAKSsHtIlwxOA=
Date: Tue, 19 May 2026 20:21:11 +0000
Message-ID:
 <SN6PR02MB415797FEDFB9BFF236B2A002D4002@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816866691.21765.15605640837157423543.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177816866691.21765.15605640837157423543.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8514:EE_
x-ms-office365-filtering-correlation-id: aaf1ffb0-b777-4db2-2ecf-08deb5e42af0
x-ms-exchange-slblob-mailprops:
 02NmSoc12DekrR47MFWXRYzut/69urIxSm3WU/J9mng8AtPaCI5GKPxAzaoVDbt8QndNOnyqwSN3c2VF8Kf2RNd0lCg3WmI1h+0SJUNwR9aUrcZk3GnqlcPgq7LlnHDU59+VS9ITFufbP3u7mF2o/cn3xNG2u0QuEWFPcmV/waDEaXFYgG5B++ti6vt04adBajAGT/KokjR12HYhOsWT29v29BUq97dJlPkV/9MrP4z6H419WJxUD7tH3R+PIev43ysjuBozKtMvtMhCkb2Pe7FnXgTNUEiH2J+i94FczxCcNW5gkZAKPgnBBe8EFLH39mjSQhPlYY2/IJ/Tmd0N97sawzRPlCA6N93QLH5SJE/47WxTDSsooi4l1QxQnx3UN4+9SMARbGxOz9OD4AjA4nkx+Kvdr0SSCDEvMP3IhIo/VTVLaSYg/np08rpwu+2XbZWsaI4po9UJu2MBEnqwqcrkb9bajwCHhuI33O7l83p56n1k9cyJz45bMboKWH1J54Xpjrj9w7yx29CIXQp0TiR5aU00k7yj+6wMKgWBE25FRU6vkGwd+uN7QPPebkLv3emviSlKTwiW9Oofqeeq9VYzu35YKhQT1RyZ8tFBTuZ5+fVVKneFWyKuIJimmL+EwZ1//vaCPMJoqYdKoZMZ80KxvYLudVXLRAJ50l3kRUfrf3o4JFUS21EZy33NO2t3FLZgdlmSTi78CzXdZEscsId7ENjjAVAeNeC0qPO4jw0HiD41xom88R4LyW2K1fLK
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|19110799012|13091999003|41001999006|15080799012|8060799015|12121999013|31061999003|51005399006|19101099003|37011999003|55001999006|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3NXamZxcHBrSnpzVjRZbG1TemZlTS9kU1ozdHpGSG92anVKRk1xVm92MmFx?=
 =?utf-8?B?azJmZ0RIRFFWSWtKV2gxai9NZ2pISFdhZTRoSFc5aGdSWmlPTDg4T2NvSTJh?=
 =?utf-8?B?czFsNzVKZFNVWWE0S1FhTnErUEdCc0JLbHluNExFclQ4L0dveW4rSzYvZ1dR?=
 =?utf-8?B?M0dRK3ZPUGt2MnIzbDVTemFpbWh6SFZqSXZUZWFnNkl5V2doKy9NQjh4TzZa?=
 =?utf-8?B?M1hxSXJsd05rTDhoVWFrSEJUTEN2UFNZaUM0U1pOZUtQMENrU0kvVUlVSURy?=
 =?utf-8?B?RUdLSnM0cGduVXo0L1JKT3g5SkdZQWdqT1MvbmFKUi9QYjRKaFFyOFBnNXhZ?=
 =?utf-8?B?S0RidFlrd3Fjb0ZqSWs1MGxTSHh6ZllsWUt4VkdXcWxpY1VsMjNQalYzYWt4?=
 =?utf-8?B?UTE0eENRRzd0YU1UMzNxUWU0LzFmZGU2RkJjMnNwSUVJYXVsT3d4TWhqYXRV?=
 =?utf-8?B?TmZUd3JGTVhkLzJmMVVPRFI4dk5IR0w4Q2JqeXdraGY4WnFzNi9PY3dsbksr?=
 =?utf-8?B?S0pRd3MxeEpxME5tVUswWTk3S1BxVk9QbmtFZ0szMXhOS0JWNFlrNVIyMEg0?=
 =?utf-8?B?QUhpWGdKWFN0Ukw4NW9uVGY0NFVwam1SZWdzMzRURk9kbzBhSVFLRXl3WGpv?=
 =?utf-8?B?bmx1dTNzSWloVXFVZWNUM0JTamZCSENreTcxOVh5bUkzL2RrT3ZMYzh4bDlR?=
 =?utf-8?B?QU1pZFFIYUljaE8yTTNsYVdkN3B4TWtFNmpJZlBoc2p1WndjQVJkOFYvRkpi?=
 =?utf-8?B?S1NxUkZHYUFVZVdUbDV3N1dSWUVCVG93a1dkUEJ4SFdpTlgwd252WWlncEt5?=
 =?utf-8?B?Z1NSM0ZoTTRSa2VPMUd4ekJPNXhvUGNteUR4Nk5PSG1wNzJDNGpnWGFoaGJN?=
 =?utf-8?B?SXVKS2dKaDlLWjZ5UTdheGdxakE0OWhDczUrUHBqdG9kT2JSSnVzaUxRdlEz?=
 =?utf-8?B?bFB4bGRXL0I5T2N2cTFCY25ObjEzZlFMV1VlRFVqWlNxWnE1K3F2WjRLR0Z5?=
 =?utf-8?B?elhaN2g4UWNMUTBtcDdyQ1M1RkhxZlhSVy9CaXJTZHF6NjBPUWdhM1JVUVZz?=
 =?utf-8?B?V1UxVzQ1bTVLOXpzTjB4c0hsL2ZtamlCdHpJbWw3NGJpMkhET3JlRDQwRTNo?=
 =?utf-8?B?aEtRQlhLZW92dGxrTHM3aUhNUzhNbXdxdDZyQm10M3htekwrV3lYbWZTTFdV?=
 =?utf-8?B?NExoRk1hdEVNTnhtWEZMQjljRUxpcDZiN3ZscmRHc3V2cjlPZzE5K0hhdnRV?=
 =?utf-8?B?SFByYWNHaEVEdFczeDEzWGZxVEV3Q2dPUWRNN04zdnl3L0huNUdWOTlEQ3hv?=
 =?utf-8?B?LzdDTVBqYnI3dUVBRmttZ0dxV1ZaaWczaDB1cVcxOXBkMTlBcFhQRzlCR1ZD?=
 =?utf-8?B?RjU4bFhQN2lIazBsV0VMUmxpRTF4TlAxWGxQV01NZ3BlTXpoU0VobTl4d1pL?=
 =?utf-8?B?SGJQYTBET285c3lqSmRHK3lJd0dvY1Z1dUkzVVpxNXplWHpFZkVCM0tYNkll?=
 =?utf-8?Q?crTxhw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zk1vUi9LTWcwQzYzbUIxRHQ1Nmt3Vkg1eWlCZ0hPakJPdk1jdkVXWlQxNjVi?=
 =?utf-8?B?SmJWWmZkN0tjL1lWa3BBSGhrY09iVkNXN1B3cGc5M01XVDFkajNDK01zYjlN?=
 =?utf-8?B?dWRMb0dhQXMvK0c3a2RGQjJsb3VjcFRSclM1NXhsdWtpc1pWcU1Zaks4ZXBF?=
 =?utf-8?B?dDZpWCtpSG9VRm42Y3M4YjNVTU1BTHRrVUY0alNwNEp0SVRQYzdwdVluaGhx?=
 =?utf-8?B?eTd4d2UwNWpFQ3dmOUlwL3YyK1dGZWcvWmpmZVp1SmVCakM2d3NpZE1jb01B?=
 =?utf-8?B?ajZiZmQvQkh2NnFDUnJVTkMvQVpyNFcwYm1IT2lyRWhnQjAzOGtuOWJ1ZmJ0?=
 =?utf-8?B?VkpIYVJNNWZuM1BNbmlVa2FobTBYV3gvQjhOSkVrMnlWR2Z3cWZ1RHo3VG1z?=
 =?utf-8?B?ZjdDTzk5NE9LYk91RDBQSitxWFliRmNnaDdWSVNxbWdGZW1UYWRiTjhEMW8z?=
 =?utf-8?B?RXhteklRc29OcGptaTZNYmhUeXgwUDlxSjJES0tYWUNaVHEwczZGVm16NFFO?=
 =?utf-8?B?di8vYnhJSzVibk1NQ0VpZlF4clhLS3BoWldmeDBWc3oydnUrLzdjYnJhYm95?=
 =?utf-8?B?eVorQ0FKTVlnc0ZqVzBNOUZ3bElOS1NTbXFCTTVONTRFdnFjVFJsK255WUtY?=
 =?utf-8?B?RzhwRDhxa2lEekgwYXBVVmFqOTByWDFVSFpTVmRXS2owc2dBNXBma3R0VEoy?=
 =?utf-8?B?a2ZoWXpQTEdNQWwreUhzU1lTZWx6RzZwQURsRDFTUlpnLzRPdW00dXpWU1lM?=
 =?utf-8?B?T0JFdzJUL05Oa0J5L09rWXdwMXV3bVl2WGx5WWhFZnpYUStnaE92dFFLbWxz?=
 =?utf-8?B?WUxheTRWZldyUDQvbHdhd3BOb3ZLWklSdEVsOTlabm9wL0hnTXdVSWNleWVU?=
 =?utf-8?B?aUNCMSsyT1pVLzRHendQT3N4cm45WkZMaTIvZU9ZTFdhNmFTZ2JhbXNyb0dn?=
 =?utf-8?B?MURWMk4zdmM4THJuOXFjNkhIdmdHeXpoNngvenRLeWxaMVJBN0JQbFlwd1FR?=
 =?utf-8?B?YTg3cERTcWNVNnFKdHNXV0VaMmcrMlQyd0F2Q3JPZjBrTkFRY1pYUlN0Y2hN?=
 =?utf-8?B?dlN6RzArTGJ1NFpYR0ZOK0RIOGpnekZpM0FzcmN6M3Z4QlZobG5xS3Q4Tm4v?=
 =?utf-8?B?T3U4d3lOZ0k5UnR3bTdHQTl3d3pPdkRyRCtuL25mNHJaZWFQeDFWanVKb0M2?=
 =?utf-8?B?dHJuSXJzQzJHMmxWK1pFaTRpN1VCZ2lZcGxmQVIzcWJtZEp3WllSUndWMTR2?=
 =?utf-8?B?Wi9uTlZVTWtDaEtJL2M0RzNJc25YVWIwVzZiMlVHL0F1U3lZWm9zM1BWRWU2?=
 =?utf-8?B?dHNrRVRWUEd1YkVUMUI0QytBSTMrbDRZeE5STHk2TjFvc3JrQkNjOEJmZHN1?=
 =?utf-8?B?aVU3RXNnUDdjdldZSnNOUkplV0ppQURodjRGVkNXYkhodWR5c1lMVGRISHVW?=
 =?utf-8?B?UlFscjNockc1R3FCcTEzS0xaOFAwc3l1WU5FMlYzb3JhdGVOZlhBenVzU1lx?=
 =?utf-8?B?MWFsTmFFbk9MZkFjeTI1dlJmd01Cb3A5UUJWQ1JaWEZUQWFQeGw4S0dZNDJt?=
 =?utf-8?B?NjhaMVF1ekw3VDZEeGhUdkJ1elRnYjJWNnR1OUZrNVRmSGJZYjF6UVBFMnFO?=
 =?utf-8?B?Z29DVnV6bTE0Ym1HbUh3d3RVSmpaYnpDN0RkcWhCSjgvaVZqUkJsdU8zZTFD?=
 =?utf-8?B?cjdkS2FiRkxHZkd0U29hZ2RQRHJ4WGF2cTZkN1ZIZ2taRFBpaERLOEVlWmhz?=
 =?utf-8?B?VVFtVE4wYnZUNEovZytqMnNyaE5KTituQkVaQWk2akIrSUMzQlpwK3RQVHB6?=
 =?utf-8?Q?ym+WBENCECXMGrYrNiA1ej2oxr+3/I/Wi9QFQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf1ffb0-b777-4db2-2ecf-08deb5e42af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 20:21:11.0471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8514
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11035-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:dkim]
X-Rspamd-Queue-Id: C83B4584990
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVGh1cnNkYXksIE1heSA3LCAyMDI2IDg6NDQgQU0NCj4gDQo+IGhhbmRsZV9w
YWlyX21lc3NhZ2UoKSBpdGVyYXRlcyB1cCB0byBtc2ctPnZwX2NvdW50IHdpdGhvdXQgdmVyaWZ5
aW5nIGl0DQo+IGFnYWluc3QgSFZfTUVTU0FHRV9NQVhfUEFSVElUSU9OX1ZQX1BBSVJfQ09VTlQu
IFNpbmNlIHZwX2NvdW50IGlzIHJlYWQNCj4gZnJvbSB1bnRydXN0ZWQgaHlwZXJ2aXNvciBkYXRh
LCBhIG1hbGZvcm1lZCBtZXNzYWdlIHdpdGggYSBsYXJnZSB2YWx1ZQ0KPiB3b3VsZCBjYXVzZSBv
dXQtb2YtYm91bmRzIHJlYWRzIGZyb20gdGhlIHBhcnRpdGlvbl9pZHMgYW5kIHZwX2luZGV4ZXMN
Cj4gYXJyYXlzLg0KPiANCj4gaGFuZGxlX2JpdHNldF9tZXNzYWdlKCkgaXRlcmF0ZXMgb3ZlciBz
ZXQgYml0cyBpbiB2YWxpZF9iYW5rX21hc2sgKHVwIHRvDQo+IDY0KSBhbmQgYWR2YW5jZXMgYmFu
a19jb250ZW50cyBmb3IgZWFjaCBvbmUuIEhvd2V2ZXIsIHRoZSBwYXlsb2FkIGJ1ZmZlcg0KPiBv
bmx5IGhhcyBzcGFjZSBmb3IgMTYgYmFuayBlbnRyaWVzLiBBIHZhbGlkX2JhbmtfbWFzayB3aXRo
IG1vcmUgdGhhbiAxNg0KPiBiaXRzIHNldCBjYXVzZXMgYmFua19jb250ZW50cyB0byByZWFkIGJl
eW9uZCB0aGUgbWVzc2FnZSBidWZmZXIuDQo+IA0KPiBGaXggYm90aCBieSBhZGRpbmcgYm91bmRz
IHZhbGlkYXRpb246DQo+IC0gQ2xhbXAgdnBfY291bnQgdG8gSFZfTUVTU0FHRV9NQVhfUEFSVElU
SU9OX1ZQX1BBSVJfQ09VTlQNCj4gLSBUcmFjayBiYW5rcyBjb25zdW1lZCBhbmQgc3RvcCBiZWZv
cmUgZXhjZWVkaW5nIGJ1ZmZlciBjYXBhY2l0eQ0KPiANCj4gRml4ZXM6IDYyMTE5MWQ3MDliMSAo
IkRyaXZlcnM6IGh2OiBJbnRyb2R1Y2UgbXNodl9yb290IG1vZHVsZSB0byBleHBvc2UgL2Rldi9t
c2h2IHRvIFZNTXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTdGFuaXNsYXYgS2luc2J1cnNraWkgPHNr
aW5zYnVyc2tpaUBsaW51eC5taWNyb3NvZnQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaHYvbXNo
dl9zeW5pYy5jIHwgICAyMCArKysrKysrKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDE4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9odi9tc2h2X3N5bmljLmMgYi9kcml2ZXJzL2h2L21zaHZfc3luaWMuYw0KPiBpbmRleCA4
OTIwN2FhZDdjZjFmLi41ZDUwOTI5OWYxNGQ3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2h2L21z
aHZfc3luaWMuYw0KPiArKysgYi9kcml2ZXJzL2h2L21zaHZfc3luaWMuYw0KPiBAQCAtMTkwLDcg
KzE5MCw5IEBAIHN0YXRpYyB2b2lkIGtpY2tfdnAoc3RydWN0IG1zaHZfdnAgKnZwKQ0KPiAgc3Rh
dGljIHZvaWQNCj4gIGhhbmRsZV9iaXRzZXRfbWVzc2FnZShjb25zdCBzdHJ1Y3QgaHZfdnBfc2ln
bmFsX2JpdHNldF9zY2hlZHVsZXJfbWVzc2FnZSAqbXNnKQ0KPiAgew0KPiAtCWludCBiYW5rX2lk
eCwgdnBzX3NpZ25hbGVkID0gMCwgYmFua19tYXNrX3NpemU7DQo+ICsJaW50IGJhbmtfaWR4LCB2
cHNfc2lnbmFsZWQgPSAwLCBiYW5rX21hc2tfc2l6ZSwgYmFua3NfdXNlZCA9IDA7DQo+ICsJY29u
c3QgaW50IG1heF9iYW5rcyA9IHNpemVvZihtc2ctPnZwX2JpdHNldC5iaXRzZXRfYnVmZmVyKSAv
DQo+ICsJCQkgICAgICBzaXplb2YodTY0KSAtIDI7IC8qIHN1YnRyYWN0IGZvcm1hdCArIG1hc2sg
Ki8NCj4gIAlzdHJ1Y3QgbXNodl9wYXJ0aXRpb24gKnBhcnRpdGlvbjsNCj4gIAljb25zdCBzdHJ1
Y3QgaHZfdnBzZXQgKnZwc2V0Ow0KPiAgCWNvbnN0IHU2NCAqYmFua19jb250ZW50czsNCj4gQEAg
LTIzMCw2ICsyMzIsMTEgQEAgaGFuZGxlX2JpdHNldF9tZXNzYWdlKGNvbnN0IHN0cnVjdCBodl92
cF9zaWduYWxfYml0c2V0X3NjaGVkdWxlcl9tZXNzYWdlICptc2cpDQo+ICAJCWlmIChiYW5rX2lk
eCA9PSBiYW5rX21hc2tfc2l6ZSkNCj4gIAkJCWJyZWFrOw0KPiANCj4gKwkJaWYgKHVubGlrZWx5
KGJhbmtzX3VzZWQgPj0gbWF4X2JhbmtzKSkgew0KPiArCQkJcHJfZGVidWcoInZhbGlkX2Jhbmtf
bWFzayBleGNlZWRzIGJ1ZmZlciBjYXBhY2l0eVxuIik7DQo+ICsJCQlnb3RvIHVubG9ja19vdXQ7
DQo+ICsJCX0NCg0KSW5zdGVhZCBvZiBjb3VudGluZyB0aGUgYmFua3Mgd2hpbGUgZ29pbmcgdGhy
b3VnaCB0aGUgbG9vcCwgYW5kIGNoZWNraW5nDQphZ2FpbnN0IHRoZSBtYXggb24gZWFjaCBsb29w
IGl0ZXJhdGlvbiwgY29uc2lkZXIgZG9pbmcgdGhlIGZvbGxvd2luZyB1cA0KZnJvbnQgYmVmb3Jl
IGVudGVyaW5nIHRoZSB3aGlsZSBsb29wOg0KDQoJCWlmIChod2VpZ2h0NjQodnBzZXQtPnZhbGlk
X2JhbmtfbWFzaykgPiBtYXhfYmFua3MpIHsNCgkJCXByX2RlYnVnKCJ2YWxpZF9iYW5rX21hc2sg
ZXhjZWVkcyBidWZmZXIgY2FwYWNpdHlcbiIpOw0KCQkJcmV0dXJuOw0KCQl9DQoNCk9mIGNvdXJz
ZSwgc3VjaCBhbiBhcHByb2FjaCB3b3VsZCBub3QgcHJvY2VzcyAqYW55KiBiaXRzIGluIHRoZSBt
ZXNzYWdlLA0KYnV0IHRoYXQncyBwcm9iYWJseSBPSyBzaW5jZSB0aGUgbWVzc2FnZSBMaW51eCBn
b3QgaXMgbWFsZm9ybWVkLg0KDQpNaWNoYWVsDQoNCj4gKw0KPiAgCQl3aGlsZSAodHJ1ZSkgew0K
PiAgCQkJc3RydWN0IG1zaHZfdnAgKnZwOw0KPiANCj4gQEAgLTI1OCw2ICsyNjUsNyBAQCBoYW5k
bGVfYml0c2V0X21lc3NhZ2UoY29uc3Qgc3RydWN0IGh2X3ZwX3NpZ25hbF9iaXRzZXRfc2NoZWR1
bGVyX21lc3NhZ2UgKm1zZykNCj4gIAkJfQ0KPiANCj4gIAkJYmFua19jb250ZW50cysrOw0KPiAr
CQliYW5rc191c2VkKys7DQo+ICAJfQ0KPiANCj4gIHVubG9ja19vdXQ6DQo+IEBAIC0yNzQsMTAg
KzI4MiwxOCBAQCBoYW5kbGVfcGFpcl9tZXNzYWdlKGNvbnN0IHN0cnVjdCBodl92cF9zaWduYWxf
cGFpcl9zY2hlZHVsZXJfbWVzc2FnZSAqbXNnKQ0KPiAgCXN0cnVjdCBtc2h2X3BhcnRpdGlvbiAq
cGFydGl0aW9uID0gTlVMTDsNCj4gIAlzdHJ1Y3QgbXNodl92cCAqdnA7DQo+ICAJaW50IGlkeDsN
Cj4gKwl1OCB2cF9jb3VudCA9IG1zZy0+dnBfY291bnQ7DQo+ICsNCj4gKwlpZiAodW5saWtlbHko
dnBfY291bnQgPiBIVl9NRVNTQUdFX01BWF9QQVJUSVRJT05fVlBfUEFJUl9DT1VOVCkpIHsNCj4g
KwkJcHJfZGVidWcoInBhaXIgbWVzc2FnZSB2cF9jb3VudCAldSBleGNlZWRzIG1heCAlbHVcbiIs
DQo+ICsJCQkgdnBfY291bnQsDQo+ICsJCQkgKHVuc2lnbmVkIGxvbmcpSFZfTUVTU0FHRV9NQVhf
UEFSVElUSU9OX1ZQX1BBSVJfQ09VTlQpOw0KPiArCQlyZXR1cm47DQo+ICsJfQ0KPiANCj4gIAly
Y3VfcmVhZF9sb2NrKCk7DQo+IA0KPiAtCWZvciAoaWR4ID0gMDsgaWR4IDwgbXNnLT52cF9jb3Vu
dDsgaWR4KyspIHsNCj4gKwlmb3IgKGlkeCA9IDA7IGlkeCA8IHZwX2NvdW50OyBpZHgrKykgew0K
PiAgCQl1NjQgcGFydGl0aW9uX2lkID0gbXNnLT5wYXJ0aXRpb25faWRzW2lkeF07DQo+ICAJCXUz
MiB2cF9pbmRleCA9IG1zZy0+dnBfaW5kZXhlc1tpZHhdOw0KPiANCj4gDQo+IA0KDQo=

