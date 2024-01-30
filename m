Return-Path: <linux-hyperv+bounces-1481-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5D0842B01
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 18:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABC51F26FAB
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F7012A14C;
	Tue, 30 Jan 2024 17:32:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021006.outbound.protection.outlook.com [40.93.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6361128382;
	Tue, 30 Jan 2024 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635949; cv=fail; b=ZpCSFuBdIfHYTSrsSBxNsiWN0o3EBdnpx+eX9SpyTpF0rYa8p/Lilxnn6uUCzD7FwFTEdq5vJtxfF1wGG3YwEEWyaNgtiEuwwU1945dhtm1Ybru1Ga/zOZbsuqFHgCgOcfmLsj9U6dtLGyOCcb7evaizZESj0YvkFNVNNYcGh/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635949; c=relaxed/simple;
	bh=6eW6bez4l6+vVj6IBTt5kKG+UMhOfeZOXCfsLSRkimo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GuhAhd7oelWMTzOgeOyyT7DTegOuX+jXqlXAqT1m5B91ocYIxIM64cswzyQqwuBUEHjkK+BuR5YO905munUYD76qZJ3SRAXocCu5dClo2BeactrhoBkd+j0jdFKTRWVWzQ1RNd5RkKUvSQkrWyWXGjes4MOrntIvSm3/U3/xEGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; arc=fail smtp.client-ip=40.93.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qjk74iZrrcUH1QrA923lc7b26HmKX7Yu14jdValx++mmqZwBoSdi7Iz0jMBLO/aOCYNsS/KqoBKjfZ7xvgdetKbGFqnTAV3ofGPq7GkircZ3Xlv9Rf9cCzHmk6OanPEzUp7fVRwdISeyLia7kkL/zNV9pNVKK499Fh7FTI2n0ED/FEGfKCm/yKsYQPNdkYGajKm+hEj7xIfAwPDjgz7vb3mc9LpnQw354miPjAhCfFsGkpmwK05xIH+nTCGF0S2QRp9XERoBgzY/uRc2NoVXoxJaFk7ZbQnCpNWHdQ4OJQI3A4scF+KiGQlJrARzmjntARQ/F9aEDfkOBkYBPaMAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eW6bez4l6+vVj6IBTt5kKG+UMhOfeZOXCfsLSRkimo=;
 b=jqlIt72z11UtpRJDe7ubdLKRhI9wyB5+tjXhtSRp+uTjQpTnrlYHibU/tDVpOrlZczWfLEHQ/xoWZ1OuescPN2qK6zAGulMg+5QlxhdsqNhdI6X/4ZFXZ1THqfOFlCDWWECT5dMFSrGJazF0Clz8radfJxlxGWhHuhjfrvHYE6jdVOBw8DVcVgPkHYyJTc/HKDGJxmMYT3GD/JVpsPcuZZWkP01rcl6srEs9hCtWeLB0B7kq7TIhjJRX4hdhuAru06rlbcoBMHypkBitV7RYEckSsZfVTWJJ2y3Rg/yjYNeGxWq9foS0f/dz1S3l8THiJlTNZ2SfD+FbbLuQNyHCKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by IA1PR21MB3595.namprd21.prod.outlook.com (2603:10b6:208:3e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.6; Tue, 30 Jan
 2024 17:32:23 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::5d07:5716:225f:f717]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::5d07:5716:225f:f717%4]) with mapi id 15.20.7270.007; Tue, 30 Jan 2024
 17:32:23 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>, "yury.norov@gmail.com"
	<yury.norov@gmail.com>, "leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Souradeep Chakrabarti <schakrabarti@microsoft.com>
Subject: RE: [PATCH net] hv_netvsc: Fix race condition between netvsc_probe
 and netvsc_remove
Thread-Topic: [PATCH net] hv_netvsc: Fix race condition between netvsc_probe
 and netvsc_remove
Thread-Index: AQHaU2VfpkrJr+izKkeQOwCcE2c/2bDyl7Xw
Date: Tue, 30 Jan 2024 17:32:23 +0000
Message-ID:
 <SA1PR21MB13357264DB2B49C20B8C375BBF7D2@SA1PR21MB1335.namprd21.prod.outlook.com>
References:
 <1706609772-5783-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To:
 <1706609772-5783-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8fd91f70-2d72-48db-9f9a-ccb2b66334dd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-30T17:10:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|IA1PR21MB3595:EE_
x-ms-office365-filtering-correlation-id: b801d3af-7c9a-4e6d-f143-08dc21b96b37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tGcAteZWtjdbt0XVpQqi1EK7J7BigNFwr7YVooLjhU7HTyR2xOvX9RbJc2k15HOsoXzQ8zmj/KRTSWcWbtuKrruUDSFqiabkQV4uVfnpHuoFozsC4NPfNpk2SHgBs8cqYQ8w1pA18pE3H3j3BpKrH40k0TUidSoWZCZ6nU9p2CSv2YJwp9L23RJFIg2/KyM3xDZhHfSSLyNmxyTOPBlTCk7O4osh2H1oq9XsXanxViq6kG76DgPbJtx7OrVv3a5LSAqsNza3IQN8E3fBP0mXpfXww3R4CqD6spVMSL9YiZfiYt5x8/xI3xXJbMY88w5DDTQU30SZWpfikqp0o7yiHcRdybfR2rlZlbQfaVdGu2ND6Axqg3HCbTYUZZqWnZV7oMv0O9vLH1tQdi742tBrbVJPlPdM1CIYGhPxZnxsgIJaN5he6jIMQgfX+Us3DWvAV7iSOMSz0btM4NPrZY//8gpBEoS2JKZxx/uIW4BdXlEVc+O6So+hzjL5WferYcfsrJ2M14+T5a1wHCTHZNxFOyteIQarxdfxNpmSg5l5bMHFINwGOsKTuxAqTWG3hlfo30+8qs6rvsM0Z9NIFbCC8UurnTF0nyKnaSUdolo12LsQqwsCdb7ueLCQq8bigUQ5LK+ugJklfqMSH6YgTM26IA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(396003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38070700009)(7416002)(33656002)(8990500004)(2906002)(41300700001)(921011)(55016003)(6506007)(83380400001)(26005)(10290500003)(478600001)(71200400001)(86362001)(110136005)(66446008)(316002)(107886003)(66476007)(76116006)(64756008)(66556008)(66946007)(9686003)(122000001)(7696005)(5660300002)(82960400001)(82950400001)(52536014)(38100700002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aYmKhr9Er9OmqnTGwsxo1jyswljc35D5ZMDsAkpHQ+z8A9c6rnm5tkn/6h1z?=
 =?us-ascii?Q?v5kvn+sBiHjlbaBYfK6Knn0rS8vSzmr52UZc6VuHX3Hie2jREpjS1lueNxtU?=
 =?us-ascii?Q?ixiQsb8JF7+s7l61D8clZacho+oA2UVGJWWa3cYXCf+Ls+tbIYh/xCaTYofC?=
 =?us-ascii?Q?Q30CMTG49Dwqf+NlcbaFM9RQnsGjhP/uNe5Hg2QwVuTz7mIIz10oCG0J+ZPG?=
 =?us-ascii?Q?ubBjIghv67NQs0rmR/E+vM7HAG8xsUC84MtjzCRwfmIoOox5dEwyrhPlqLjx?=
 =?us-ascii?Q?Aqy0TpCyNAsjZsoCLFrGcIewYiltCD78afDshvTaeKxp3q2BYy0dRP6ZI6g+?=
 =?us-ascii?Q?3q3KUvwo/vhp2G9Rd8YNzHt4dB00LIUG+1RPXTyN+aDOpEfGv8nm+VVhh7Ti?=
 =?us-ascii?Q?DesovmdlUy3qI6sTwyTmz79xUJvl3gAHdsBJf9xubpXTSRf895KCUHMciGg2?=
 =?us-ascii?Q?vr8uA2qOEy5vLsIvusLY90F6t7xj6WWG1ZIb4fyAchAHQkgpb0Z4BuakZpSg?=
 =?us-ascii?Q?gGwr8oAv1xwj8aAXrOyXhrxEPWuUnvl8dM4/M2LrhCxdFO6tCdizLEFscet0?=
 =?us-ascii?Q?D0HmJW5XeYQbmKMYhQRupNPbKSw1/8kGl8VuaAWGYwbPAMIZ8yoP6PhaS77o?=
 =?us-ascii?Q?gkazLSgsut534VTqpzpcuzmkqIqb4rtFpA9RRaQ1A1xJWk0Mb2A7y3kslUFD?=
 =?us-ascii?Q?Bs7Q5vPFHoQcXJVmAxIIXWAT19wgbQKZOsA+qUyxphm9PnlztQ+umdYggHvs?=
 =?us-ascii?Q?KcL8CVq0gCaVzXlVi2FvK5evnHHbvyfbUz7Lo7fRWKK6Mwaq45ZOqhm1Gm7K?=
 =?us-ascii?Q?OsKzjxqG17KPDYdqntA0DLSgUv1Qfp3VAiA57Ajcaxf0kc7NgTHMmGxwoU/M?=
 =?us-ascii?Q?9Tg3skKj81KTR2dnYDY+ULzrYPlzRC6+2p7+cJ55cTz4evZVsBLeG2il+iIi?=
 =?us-ascii?Q?vb1QzGMOoI3ISoM4tZtCTqilPg5ePZpaP2KkSNfL+HtrwJqFD0d0pfZdCu0n?=
 =?us-ascii?Q?n4WkvU4mAEcwU6ygPFSAqzKuUhJz5eLwx+TD12RhQKg8DVSXa20bAKixSeze?=
 =?us-ascii?Q?BunF6fGsCb1/iQc7nlpRzvi1YEOcsGL11Uxmo6f7bigfRM7REgKW5SuzfqMv?=
 =?us-ascii?Q?NHUNAW1UMZL4I+jCVOfHYWamBVbMnZclOyDJzc3HYinNhDvrZgiUhmKSBRFx?=
 =?us-ascii?Q?Ma5tOWQ8qvOx0mzcEehD3vicagBELrgllV8DvirKtRadixTFQiJR1/usXD2t?=
 =?us-ascii?Q?d00tqSGZ6DEYZ31C+r8hJTnQJ7PLeLQiB8uir0cy/H1idAQPpKjaD1BqUZA3?=
 =?us-ascii?Q?Gw4P3v9PDhfOVpLqvxl6sub04s4hut0raTVQoVzAlvuZBjL61v4aA2hCCNFD?=
 =?us-ascii?Q?xmdmuHGPBSbugqkVWV5DwgE5i9249OtO62ZisVQVkFw9pK1ccaVON1KYzInP?=
 =?us-ascii?Q?y93OJ3QH7yFcIqpYi9k2N1z49M8d9hWs97U4oddv7kXlTFBXyT0TvsK+QYEX?=
 =?us-ascii?Q?FSWcOrGwKavvIEgS8tGSWMCUPkVng/yTcFBAdyq8fpfs0B75XCRor7D6xKXn?=
 =?us-ascii?Q?bw5DroiwhKLVGZihAnA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b801d3af-7c9a-4e6d-f143-08dc21b96b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 17:32:23.0658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: piAQD3nN5ikCFjNRMeJfrsVH9gVCMX2YuS2ZrMSmF1/uVeg/AIwqY4Ok/Qy0KHbo+NgUE14SCh4cqnqR8OthjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3595

> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Sent: Tuesday, January 30, 2024 2:16 AM
> [...]
> In commit ac5047671758 ("hv_netvsc: Disable NAPI before closing the
> VMBus channel"), napi_disable was getting called for all channels,
> including all subchannels without confirming if they are enabled or not.

s/enabled/created/

> Which caused hv_netvsc getting hung at napi_disable, when
> netvsc_probe()
> and netvsc_remove() are happening simultaneously and netvsc_remove()

Technically, they are not happening simultaneously: netvsc_probe() itself h=
as
finished, but the work item scheduled by it has not started yet.

> calls cancel_work_sync(&nvdev->subchan_work) before netvsc_sc_open()
> calls napi_enable for the sub channels. Which causes NAPIF_STATE_SCHED

Technically, nvdev->subchan_work has not started to run yet, i.e.
netvsc_subchan_work() -> rndis_set_subchannel() has not created the
sub-channels yet, so netvsc_sc_open() can't run.

It would be great if you could briefly explain how the NAPIF_STATE_SCHED bi=
t
is set and cleared, e.g. it's pre-set in rndis_filter_device_add() -> netif=
_napi_add()
so if the sub-channels are not created, netvsc_sc_open() -> napi_enable() w=
on't
clear the flag and the flag remains set for ever for the sub-channels.=20

> bit not getting cleared for the subchannels.
>=20
> Now during netvsc_device_remove(), when napi_disable is called for those
> subchannels, napi_disable gets stuck on infinite msleep.

The patch body looks good to me. Please post v2 with an updated changelog.

Reviewed-by: Dexuan Cui <decui@microsoft.com>

