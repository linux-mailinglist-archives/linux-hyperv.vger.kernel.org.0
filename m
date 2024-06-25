Return-Path: <linux-hyperv+bounces-2492-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DFA9162AB
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jun 2024 11:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33072885B4
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jun 2024 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959FF149C6C;
	Tue, 25 Jun 2024 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WiVa+xlO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2096.outbound.protection.outlook.com [40.107.20.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A412EBEA;
	Tue, 25 Jun 2024 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308302; cv=fail; b=pOmy1CoGSJYFD8nbVMlpyVR2dtPtt7xgTxtRd50pHrb3GYi2sU2j83Ic9URBfh5bEm1kTCp2NFXPzlYjWANZMRKl2NrNZfkeaz8p8cFIr0W7bBNvO+DAi5dQyshG8SDGHd1AG2qD0Yh76naUPH4Exw52zBF2KbJjQNPLqJRcoow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308302; c=relaxed/simple;
	bh=ABV1tYfnY1Gm9xMT5xj/KKvr4myE7RB+N2/bEEkNvEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Inz+24Sl3k0pAktPAjbSHz8nuhe8aQ4jAyzxYh6Yqb4TomxUiRn7QgDK2+gcrz9ig4CpmDaOOjTM6ERwG9TcZhLk6KzqpIc/SP+9XTflMqVUvii4OIB98/0GuFcRl47MwJbDpWoofyN7tteiYd5dVo9y6Xdw1TzusUjP2p4QswU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=WiVa+xlO; arc=fail smtp.client-ip=40.107.20.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCyOKmxR+0fYLkII/3KgALE8PQHATmqYkQM9UV1PgUOtNYQ+LiSBAD1TX3geJXfDiJfIk3dC6zzV/l/y7QAlt1quRph7Ww4jgBtv0tfBDAqX/3h6NyXf3xvHh6w8zKxHYnS0ss9HT86sZLc74FWFYl1JUBgKNijmTygWFnOXnQ0uAKIEsacndBVM4q4y9heAh8dRq3eUpVqOhAJssQOpYht7JHvEhBCN3q4ClGs7HuNQ0iHBsHzOG4jKu9GH6i1gaeeH/qmj8nUkvABbqM78JQs4bRCN/2j6fCh3LnRnB4lOA/ur/HEkVKW4/EfwrV8qoSHEs2S7yuZrthuT8vffJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABV1tYfnY1Gm9xMT5xj/KKvr4myE7RB+N2/bEEkNvEs=;
 b=ZuIQZ7aWQ02WH+ixLz0UPly2pjmNcF3Ds5xe6xESH0JXg0SJ0RKZjMg+ww6ndbU6doMEi/FkMm1Ol8OjCLMYdc5YGrqwERu7AOfvd/slX1vxLgLUpjvTlklKLjAzESByNlr8bQbR5YP3l3XMQPiJtwPEuf35XFzbMKSR6KuiXMGdLCRfQqaBPqD7QSAUZ4mSIuOzYuUImqHfNw7bHZSqpamWHUOza4NEJpb7Z5KT4GlDNfThnkiX0AJ1RnlyugQ6e6zZaesS3FbgFg5tW//R3CZIFbLo7JKgPP69rufe2Q40zPIrCL7PcPV160L2013f+GV4aU6aSF0nqtw1jTl03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABV1tYfnY1Gm9xMT5xj/KKvr4myE7RB+N2/bEEkNvEs=;
 b=WiVa+xlOCYpY22l2w22yYFCfj1RPZ4j6C9phacPl7dNKygSqn7N6v3OADkS5qIgytiU4FEw/IxbHRwHMZZOiqozjT4rRYRZI8YtO8gLzwiLB0/rr6k9CTydqbx9zbEGTtiLZxcR4Fsts7U8ffK9+f4ws7/ANVO/XFsLf/wE4pCs=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by GV1PR83MB0803.EURPRD83.prod.outlook.com (2603:10a6:150:206::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.8; Tue, 25 Jun
 2024 09:38:16 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7741.001; Tue, 25 Jun 2024
 09:38:16 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Ma Ke <make24@iscas.ac.cn>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>, "schakrabarti@linux.microsoft.com"
	<schakrabarti@linux.microsoft.com>, "erick.archer@outlook.com"
	<erick.archer@outlook.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net: mana: Fix possible double free in error handling
 path
Thread-Topic: [PATCH v2] net: mana: Fix possible double free in error handling
 path
Thread-Index: AQHaxuNnszH/xcr7vUm28rJvLxKC8w==
Date: Tue, 25 Jun 2024 09:38:16 +0000
Message-ID:
 <PAXPR83MB05592AAA14AD8A95125BD5EEB4D52@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <20240625083816.2623936-1-make24@iscas.ac.cn>
In-Reply-To: <20240625083816.2623936-1-make24@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=316d650d-8498-4d0b-98d0-bd77f54d80ab;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-25T09:37:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|GV1PR83MB0803:EE_
x-ms-office365-filtering-correlation-id: d9023b35-fb89-4f20-0e61-08dc94fa8a75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|1800799021|7416011|366013|921017|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?am5ET1kxQ3pDS1Q0M0YvQ3FOQ1JjQjlEN3IvSTNLdytNOHBZSk5LaHA1VzN1?=
 =?utf-8?B?dmZybUxHMjcwRU1MS0VUZURpck4yanpyWnhCb0Y0NU1nNFY0QnhBWGptMEhM?=
 =?utf-8?B?OWpTOFJvNkxycFNCZjBLWnIzSisxc0JlRTRDci9PZEl4dDJQRS9jOTNMUmhh?=
 =?utf-8?B?YXJwVjcwS2U2WER4SVI1SmdTcm1KOUlnbDEzUmNXS1N4OXhPVTdDVW51ajNS?=
 =?utf-8?B?MGRsSXJOTWxZcHM0dzRyYUtxaitvb2VFOXpKVHlEYmhzVEh4QzBkSjZmSmtZ?=
 =?utf-8?B?UTkzOXIxL2VQMm9YN0JJMTNxRW9RUWR3cWhVYm9ZSkJEUHUyS3k3OEFTbGhm?=
 =?utf-8?B?MmhaYXZGWC9wMUN3QnBObXo2Ym13eU5Lcmh4T0F2c2t5OUVsYkJBSGVMc3pu?=
 =?utf-8?B?b3hiN0hmMGc3R3RrSlhXK0M3OHRUVzdManBjY2U0L0JOMFdUVnh6Y1VlTkFY?=
 =?utf-8?B?aU91NHJlMG82STJxakxmajRZbEZiUk1ra3BJekN6bDFQTW1JeUJ2dmRKTW4w?=
 =?utf-8?B?K3N3SFkveXNsUTJyVUdqaWI5VVN5NTFqbW5kZmkwRWRBRmNNVzluVzJRYUx6?=
 =?utf-8?B?U2Mya1dQdzlhdDRUNmkxVG1FRUgrVi9sR2RST0g3RkZHRmN2VTJKOGtIRGly?=
 =?utf-8?B?WWdMWngvN0xYWjZtcHN2d3JmbVc1UmxBY2ZVT0VneGh2Q01YcVhyK1ZBcFVU?=
 =?utf-8?B?MithWjVLUWtzM2NaaUU2R1AzZTNTOTkzN3RaZU5IQ3puZW5CQTZOVUZTT3hF?=
 =?utf-8?B?VFFvakRXVU1tZi9RU3c2bjBSYlhVZER3WXZtb3NMbm9INHg1cnQ5WU9aWkox?=
 =?utf-8?B?M3E2eGw4ZG80bkd6c1ZwY2RwN0ozbW9Rb3VoUEhMbllvSDE2RkhnY3JNYm5j?=
 =?utf-8?B?K1ZCT29Xa2IydXFIQUJHeDdqYzdVS3UxbjJZYUNBS3pVTXVFT0Zqbit2MEV5?=
 =?utf-8?B?Rkd4K3ZvU2k0NTQwRVlPczFwSndPQy9ScXhsWFArRzIyYkFReDcwclNlTHZa?=
 =?utf-8?B?RmZSZ0E2U0VnS2hoWEpWcU9mM1lteXpyTGo2NVNxUFNzUndTNFpmL1cvd1JU?=
 =?utf-8?B?U2JaeFdjMWRBcHJKYXZ0d3lnZmFsOEZpdmxGNDUxa1pDNGVhQ2MrWGFxUWFw?=
 =?utf-8?B?cDQ2Tk1tUjZodzkzY0RwK1dLOHR4ZXk2VWFadGVZcmhQWFJYd2xGaGk0THF3?=
 =?utf-8?B?aSsydkhuMnYrTUMveHU4RUc5ZGNYM0xrTm5RS00xTktPNzJEUDdvZWEweFBK?=
 =?utf-8?B?U2ZRSnE2K0l1UGlnZVMyczlYZWczdnFpNUZmanZzQVA3NmhBSU1tRSt3QVI4?=
 =?utf-8?B?MDUxUjVoZ3RBMGNTWWo1MUVVb0NScjRyUndGUnBsNHJ3eVh0ZWNUN0ZlM0w3?=
 =?utf-8?B?cDArSFF2M0RuNjk1K3V2TDJIUXRZZHBUdXU1R0NGSUhla3VJVndGd2pDVCtX?=
 =?utf-8?B?bWtkSHgrQTd0akpqemMrZnVzbjlpT2NPZXVrYURQV3VIY0NmMjdBSGo1OVMw?=
 =?utf-8?B?TCthZTdtdEN2cHR1TFdpaStrakxQNEx1M1h0Q2tJS045RWxTcEw1S2ZBZk83?=
 =?utf-8?B?QklycFcwNlE1ZitUSTNQTmJ5NGYreGVvUEJicDV2V3dHOGx5VG1sUUF3OGhx?=
 =?utf-8?B?UDBSaTdKc2R0NU1OOHNFYkNycnYrakd1TmZyOVRRQjVqMXhuUEdLbkplRzF0?=
 =?utf-8?B?T2w3VUl5TWhmVFp2cEhtUHo4U0NEdkFuaGdYMjFKNnczM0NiODRURjlhc3VW?=
 =?utf-8?B?ZlRvK3BYUGFLKzhaSDZBY1RqdTFLY05pbTdHbktTaWk2aXFmRklmdTlBQVc4?=
 =?utf-8?B?N2p6MU9LV2tCTlJtVE1NZU13K0tpV2NSdFF0bDR2TkYvM3owTE1IeVh4SGNH?=
 =?utf-8?B?em9ibS8xa2gwM21ZYitCcXo0c0NmK0NzbDJNdy9wdUlXVGg5bXRZc0I1L0lu?=
 =?utf-8?Q?miTMKPn2ShM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(7416011)(366013)(921017)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1RsVUx0bmVVSGRsOEFDbkFQRHlzU3VGNy9BKzlNQzJ2V1VDbU1USWZuWkpF?=
 =?utf-8?B?d0xUZksyUlI5ZHhaNERsTG9UZ1dHZTltUkY3ZW51cXZ2anFpUXdGTUJSOEdw?=
 =?utf-8?B?K29xTjc2UmNUYXdoSEcwMC9XdjczWVYvYmIwTlR6RDhUV0REbzl3aklxaWNY?=
 =?utf-8?B?bWlnTExveHRPQXErNkVCVG5vMXpRR1p5NXA3Vy9namlmS3I3YmxBb1ZidVlB?=
 =?utf-8?B?V0NYeFJ4dDFZeGxFeGc1ZDVBVDZheEI1MWVuM2lnZG9hakN3UFBHR21uVGI0?=
 =?utf-8?B?NjRBakdyT3FjcHN2a29ZZVgrOXVBT3haZ2RiZ29Xc3REamJwak5HNmpSN2Zu?=
 =?utf-8?B?SndUK2YweithWWZncHJBaXlhSDVMSnY5M1hJTW1MQUg2cGhNRjA1SklEWXl4?=
 =?utf-8?B?UUlmRW4wWEJZVXE0WnZnTjVxVnJIMURSYW5xaS9VSnJWT1UwbFV5dktzdFJr?=
 =?utf-8?B?eXhGK05MWjVBZWYwYTRBWUNENDlMSVNBSjFmb0xBdFZGK1QrRElVVWNpemp3?=
 =?utf-8?B?SVIwY0dFVU8wN0oxZ1ZiWkthN3d3ZFBqcWVKMXVSRjg4cHVnSHdpRmhTU3hI?=
 =?utf-8?B?RzhDSkxHeno3ZmNOdGxzdDJoMjlucWtIeEpRZlBZY3RDTWd2Ym42Q1JWWHRO?=
 =?utf-8?B?YitpUm9CRElkVW9LM21pWDl2LzhEWFFESWdGY2pIdkVhT3FBckcwUDFMTk02?=
 =?utf-8?B?Y09qOURIby9HWkpCRW9qWG81c1krM2NVbndTZCt6cml3WGZMRTVtT3V0Mjht?=
 =?utf-8?B?U2tWVXZSQ2E3NHNkajIrUDNXWUVJQVpNK29lNmZ0S0pTMEZldlp0WnhiUUo5?=
 =?utf-8?B?cTdTOC9WUmFTQ093ZFNKRWJkZ2RvZ2IwZTVlbkhtclFPZFF3S3NwY0NXaTUy?=
 =?utf-8?B?bXhveFArWkozbGhWRjgwRHNQMzdzL29UTUdlN25XZzNFZnBVR1JwcjZHd1V2?=
 =?utf-8?B?RXd5bEtxWUVqcGU3anlHNDAxMHVYY2llZmFxZlQ4bXUwb1MvZkpyN2JENkIv?=
 =?utf-8?B?eTRYVnZ1M0tveWZ4d2E0a2UweUFOVnlsd3QxOTJxTyt0cEZBSXk1d0FwLzZr?=
 =?utf-8?B?VVk0UkxhOGNYSkpLdXZYZ2kyL3VVV1F1Zkh6RkRZUjlFeW51VGdyQkMyWE5G?=
 =?utf-8?B?aHp4cW9WVEhlRUk3YWFDN2FZTHF0UWNPZjlucy9ZWTlKdnkrYjZnNE9HUXVo?=
 =?utf-8?B?bVJ4ZlFqYURKekNiRktOM2NMNFBweWc3WU1rbzJPVmFabXdjTlhRZWpjYXhC?=
 =?utf-8?B?WWM3S0RWcVZqcWp3bEgyaVRlK3ZJcXJNUTlRZHNkZkh5b3RXVmRnTjlDNXVQ?=
 =?utf-8?B?TzI5QXArT05TUFFoMy9MNkhWcVNibEpTS2w0d3M2Rk9NaGFFUU5KcXl0S0tp?=
 =?utf-8?B?aFZDdlZmNEZuOWVYeU40RThWS3JncmJuY1N1cHZhTGJqakU3b2REWndqd29u?=
 =?utf-8?B?b1NiN0g5ckgwR2xlK1hqc1RGNjlrZjhKZUp1NDlQRXAwd25rTUVFZ2hRRmF5?=
 =?utf-8?B?ZTNhb3Q0UmVPVGFqNUpqL0M2SkJoZ3grelRZUFEzZmpWM0ZXKzBCSms4OENa?=
 =?utf-8?B?OHhCc3UzMjhyaFBVZjFndzZNUE5KUEthVjR5SS91cDdBQ2VSOFBVZUNDRE9Z?=
 =?utf-8?B?a2hXZ3ZwRGlaeUJ3cHk4ZkFWaUhwSy9zejcvRDhYOHZhaTg4NTNWcEh6WTZJ?=
 =?utf-8?B?TmUvY2dsTVk5dTBVMk1jUTFSMkt6Mm80SlgrVHc2MzlVVVZFeDdaWDhkcERS?=
 =?utf-8?B?RzJ2dWExcDh1T3h3UVRsdlR1K3NtM1pEUW1uMTFJWmF0OGg1YnFFYmc5MlU5?=
 =?utf-8?B?MjZZdmRiVUIxMG1rZFhhK2t1UlZ2STlicTNYUDZ1WG1rSVJmcTNaQ0M2dmhM?=
 =?utf-8?B?akhHYWQwRUFENlp1bTRob2pmdUZzWmxvVnFYalpoNmlHd0o4QjB1WkFTZGZJ?=
 =?utf-8?B?VTR2YjZoWkdWUENOM0tqMWUzRVZrYXJZeEh0UElnbmtjbHZiT2pHTlRRcjVj?=
 =?utf-8?B?ejdscnJueGN3ZVRzUWZUVWNWTmI4Ykhjb2FlRlJ1SXczb3dzVUlEaWpGczlQ?=
 =?utf-8?Q?QpQdh6?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9023b35-fb89-4f20-0e61-08dc94fa8a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 09:38:16.5076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iESP37MZaRF669oK+IRepHXr+GLtRLdlbZKvmUI+zZNtZAuo2uRSBJZoWD820MvMK9oBIQhMw8m0qBshkcHYew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0803

PiBXaGVuIGF1eGlsaWFyeV9kZXZpY2VfYWRkKCkgcmV0dXJucyBlcnJvciBhbmQgdGhlbiBjYWxs
cw0KPiBhdXhpbGlhcnlfZGV2aWNlX3VuaW5pdCgpLCBjYWxsYmFjayBmdW5jdGlvbiBhZGV2X3Jl
bGVhc2UgY2FsbHMga2ZyZWUobWFkZXYpLg0KPiBXZSBzaG91bGRuJ3QgY2FsbCBrZnJlZShtYWRl
dikgYWdhaW4gaW4gdGhlIGVycm9yIGhhbmRsaW5nIHBhdGguIFNldCAnbWFkZXYnDQo+IHRvIE5V
TEwuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYSBLZSA8bWFrZTI0QGlzY2FzLmFjLmNuPg0KPiAt
LS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBzdHJlYW1saW5lZCB0aGUgcGF0Y2ggYWNjb3JkaW5n
IHN1Z2dlc3Rpb25zOw0KPiAtIHJldmlzZWQgdGhlIGRlc2NyaXB0aW9uLg0KPiAtLS0NCj4gIGRy
aXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5hL21hbmFfZW4uYyB8IDIgKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9tYW5hX2VuLmMNCj4gYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9taWNyb3NvZnQvbWFuYS9tYW5hX2VuLmMNCj4gaW5kZXggZDA4N2NmOTU0Zjc1Li42
MDhhZDMxYTk3MDIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29m
dC9tYW5hL21hbmFfZW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQv
bWFuYS9tYW5hX2VuLmMNCj4gQEAgLTI3OTgsNiArMjc5OCw4IEBAIHN0YXRpYyBpbnQgYWRkX2Fk
ZXYoc3RydWN0IGdkbWFfZGV2ICpnZCkNCj4gICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAg
ICAgICAgZ290byBpbml0X2ZhaWw7DQo+IA0KPiArICAgICAgIC8qIG1hZGV2IGlzIG93bmVkIGJ5
IHRoZSBhdXhpbGlhcnkgZGV2aWNlICovDQo+ICsgICAgICAgbWFkZXYgPSBOVUxMOw0KPiAgICAg
ICAgIHJldCA9IGF1eGlsaWFyeV9kZXZpY2VfYWRkKGFkZXYpOw0KPiAgICAgICAgIGlmIChyZXQp
DQo+ICAgICAgICAgICAgICAgICBnb3RvIGFkZF9mYWlsOw0KPiAtLQ0KPiAyLjI1LjENCg0KUmV2
aWV3ZWQtYnk6IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+DQoN
Cg==

