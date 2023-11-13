Return-Path: <linux-hyperv+bounces-884-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B727E9544
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 03:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCF51F20F39
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 02:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E3579D8;
	Mon, 13 Nov 2023 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jiUGlFFx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF28483;
	Mon, 13 Nov 2023 02:56:03 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020003.outbound.protection.outlook.com [52.101.56.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B3115;
	Sun, 12 Nov 2023 18:56:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2B9uN87iOU+TcT/zdxiz7jRjsF6kpRLvU0Y3I2JVjVBT924rI3zNODYGKTE4ZR90Sxbpt8l3DPtUjr/031BYpKYu71Xlbt4cEPuHxysGew0Za5NI+1UCC98mQ/5omzdvuwObVg5BTF7YXqFtXAZObdR8oKslqQnThiRGEBKoHL6Qqb+nydaxLCmql3xgo9ZGfM82vFisOrgRkiMrthQbHUqDbrbPk6Rd/IatU3ZnTQjHOA9ReGZ6864zfmCvMCPkHRjJcNdT0SF1GVUSv8FOaVzihtdrV+kxZy23wHV7VGLHTQak0Tia/D9XbERhXuuoMW3RNPJhJcrz+Pq1KLa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCvCZ+RI5RQWquQzy735geEcbdEXp8C4qPj6eqG/qSA=;
 b=TFfMLOeWwHWKlwCPIM78IIs6/nr3vzTzhMajdlTxpZbwR/kfowwooz+Iw+e2UNgJBiMNaqAJVsPTtIsH9xN07m6zboYa6XFqaCvWsXPt3p70Hd/1W4yMj5DcEIuqWIkq6VjvBgj7WwG5Tjqoq9S5Ncrbu6PRFEflPVYG/iyl+HcDfU8kVOahRLozs87lsdwc3mKpZCIxdEFrvP5bN5maLXyW0XpZZUs8V9f2zG/MRHcJCASFU9yLOqR0AwcD6Oz411wljv6fi00ASX5Z4pNHbZWHm6jOUY/ZKLxbXm7WBE9Ho9XwryH2FjUpVF3Vhi82Mh5zDnZOTs8vRizRN69cuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCvCZ+RI5RQWquQzy735geEcbdEXp8C4qPj6eqG/qSA=;
 b=jiUGlFFxIdME1DDpEZ2k1DJiHbA207vctJqeuw1Jjflm3XTAPm+qKNFgVQu4aOdxo2K7S9SSOKL9TZQ9Pvj2+PpoAkpRAsg9civkwhUoU0rleM429Cy2LXY6mygwW0W//K4RiudY4Fh1Vj6bXRfX5H8q5rvOqHEkBP2/1mmzn0Y=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by IA1PR21MB3691.namprd21.prod.outlook.com (2603:10b6:208:3e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.3; Mon, 13 Nov
 2023 02:55:58 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c1de:d3e5:8e05:1e4a]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c1de:d3e5:8e05:1e4a%2]) with mapi id 15.20.7025.003; Mon, 13 Nov 2023
 02:55:58 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net,v4, 2/3] hv_netvsc: Fix race of
 register_netdevice_notifier and VF register
Thread-Topic: [PATCH net,v4, 2/3] hv_netvsc: Fix race of
 register_netdevice_notifier and VF register
Thread-Index: AQHaE+O3d+O/3LKXnUqVpJmgJOhto7B3kJcw
Date: Mon, 13 Nov 2023 02:55:58 +0000
Message-ID:
 <SA1PR21MB13353EB2FAB9ECF0F135BF19BFB3A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1699627140-28003-1-git-send-email-haiyangz@microsoft.com>
 <1699627140-28003-3-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1699627140-28003-3-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fed65eb1-c1dd-4818-b041-a7c0e6283030;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-13T02:50:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|IA1PR21MB3691:EE_
x-ms-office365-filtering-correlation-id: 229f53e1-1aa6-445f-b485-08dbe3f41032
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lXV5FhPjs/Xi1CZv4EK24dtzWi/xcvjtzY9McuaxDvr8TSMyjKVS9kQUSxceSzqdZOebyehFmqSTSjqAcMKWHy6/l4INHALhSElC/9fZ6OuO7NOZIKhT58nkMewHjPjf5nNi01ZpR/qYCvoUUl6wY0qFS7vwEMtHdkPm+W7xHpBSMuVol8UQ36FhxmqHzt1rMyM9NzvwhFkqHb3OllLkTF/9byQwwW6duEgXq4hPbRXwXrLX+rVKlaef1Y3J9zUjHalgnOOYvTny6IUrkAjTGb+GrzXb6PXHVZcLvwXrF3kKsBvDWxpE52UaDE0uzru7OjC6t4MybkfSbwVhVphrSNBf+F15dithjUzMEHdtSoFAabVUZwh4kq9g3D/Vkgly93gnCDEt5BA9bcJXW/cipSsXdPxz18tUYiWITRcHQ/9CJRzCLDfS6RYfFEFxrcp7sIHYk2lMpAWTWmE12xXmSeJXsie9yamr8u478GzXBLvKm/HTqeqpnNxUnNjgztvQPIt0KZjz22N8b/+/ZZuj5+PBkXWve97GZmr/OctDbaRgBWBIIIAapvBN0hPeK/X4cS2ESEKgKQYijvZdayUbk3MW75k3FjA8NBPR4m7tpt7MrzYgX3qQjvRNFhBxsQVBD6YZhJ10DThxi/gu9Ty+ew6X9ubkGtemvdXXLqM5hNE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(54906003)(64756008)(316002)(66476007)(110136005)(66446008)(76116006)(66946007)(66556008)(8936002)(8676002)(4326008)(52536014)(10290500003)(478600001)(71200400001)(8990500004)(33656002)(41300700001)(5660300002)(86362001)(4744005)(2906002)(38100700002)(122000001)(7696005)(6506007)(9686003)(83380400001)(82950400001)(82960400001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wn7eMaIh2kjeigKew4v+j872VjER6bvbYBuqbFP9b/SBhK7FT05qB9mGdEYp?=
 =?us-ascii?Q?38HqwOaDFvncFKGxnY3V8uwkx56RE5U2FmFi/XvPQcpwDTqchuhHbWUSwis1?=
 =?us-ascii?Q?LmsTev45O1uVNNXQrs8bYTqtFh66bYF9IDZOSb/WLbc9biEy9qI8TnIODH5s?=
 =?us-ascii?Q?3GdZ6gl+q58Hcr/Ra6fkuI76eF1OdyL51NhOxfc9b0jQzC5jbgrB0pBFdV8K?=
 =?us-ascii?Q?UJRvBNPNeLrWwUnM/VlaZDvZ50rrAw7+ay2UGWHUqFv5PvzGRNRkDHo1xneI?=
 =?us-ascii?Q?NnGfFgl84dvqa/nrCHERnw/PW/nQx4LKFntvDjUDYLUwo988zhClHPjiYwYJ?=
 =?us-ascii?Q?oGjqFtuPsa6u7bMKOQCb0EHgEQoTpBIQUObx1FQ9crM6U4luo1JOY1YNZCTL?=
 =?us-ascii?Q?tt+xoDPX4R9T2AztLOj5SxywUrEMaVHR+Qc8IkSvVE/XjLPL0c7QjDKTYOXY?=
 =?us-ascii?Q?hPf0M5za9Y3qA3AgaLh/W0uFLcCfPPa33BipJDLP/PlPx4x57w3Yq9/l3Aet?=
 =?us-ascii?Q?7YbOeujrzpdgDCNy2OWfNSEjbKM9cgrGah9YBW0I5/HqdpeuF7YjqNW8pKWI?=
 =?us-ascii?Q?1imTiS3JubPXfPu596w6pKhTVRz6TJDuWr6w+bIodWcXTsHlOe/kQrqehJ39?=
 =?us-ascii?Q?n0yk4OeKixQwuUahAltECGTWK0LzZskbYfiWZx0Y8FFE5xZ8FYJ4YQlZQC71?=
 =?us-ascii?Q?gAucIzyDFOwAEg6QUaerKldW5jj0mgPnx72klUWU3rlwMEXzCXMvivM3kA2v?=
 =?us-ascii?Q?gsSLAa6jFyLXij8JMK64PUE6CIskaKZzDO/SnDXNbv3KhAzcckjXxw1by71X?=
 =?us-ascii?Q?S9ENgqv9I5ynVeCnetIJ5kRvfCTh7VJjzkOK28D5OsOycwJ/HQSMx9FvB8iO?=
 =?us-ascii?Q?PFs1kkUpdO60z9YjihU2BS2wd34iJZRYcA6OjSgyrL0Je3VdBTNOFZJUQITU?=
 =?us-ascii?Q?m5QyE4jZS5VFAwsR0Gs2EJsUu6QXN+VXF2YB4tM3wXX0xZDW7Jb4Q1Svgbk1?=
 =?us-ascii?Q?D3SwUPJiX9j+J8vjkewyFV2d3h2ZQBU9ToGGjJK5/XA4Safhpi9MJyBo3AvE?=
 =?us-ascii?Q?Az/hyv0jSXiEFQKaU3Pq3EY3/hisd+crXimI8q//M05G7s6spHofA/vf3Lat?=
 =?us-ascii?Q?+fSBF93ipb49nNcq62Aof4VAceCIz63A/Tpemn4MyLyJEoVj6hTWCVM0izGW?=
 =?us-ascii?Q?n7F7w2WzzZ7OwKNfQDfreGiNjZ2RvzrIQF1BIzFLjzybYH4yo5wTNDtJUF9u?=
 =?us-ascii?Q?nNefqjazV3ojIgmkadY6CJ77lNWclSxV4QjeNINWNwDjtsmch2cjwmxBq1bB?=
 =?us-ascii?Q?hT3woqHp+MmcpnhF+/0uzBAUQQE879bjWVimLHD50iC0xbP04xmNxiU71oRP?=
 =?us-ascii?Q?iVpJ8KUiCXmTntJW88pUBMl57nRAXcpvsJAi/vmkJQcWa8LuOPOnRkk6we+2?=
 =?us-ascii?Q?ZQ4o5LROIh/wPUVhWoRQ8M6TCZaU8ANAznwrfYYNrQ0lf5AmO1FiXElqYrmJ?=
 =?us-ascii?Q?oc9gGu/QY9igDc707dvDMvBGaJznITkqKHcLiY8BTYFLFKpUnJRuKCs93g?=
 =?us-ascii?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 229f53e1-1aa6-445f-b485-08dbe3f41032
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 02:55:58.6257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O1RQ8pn8I0nmOxIRKCNds91xTMzR26dQeJXD2PAMiqXtmpVyHjO6j2nvq4JseVnb9ZmkihBYJFIGRkfvsHcsMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3691

> From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang
> Sent: Friday, November 10, 2023 9:39 AM
> [...]
> If VF NIC is registered earlier, NETDEV_REGISTER event is replayed,
> but NETDEV_POST_INIT is not.
>=20
> Move register_netdevice_notifier() earlier, so the call back
> function is set before probing.
>=20
> Cc: stable@vger.kernel.org
> Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earl=
ier in
> netvsc_probe()")
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>

It's better to post a new version that follows Simon Horman's suggestion,
i.e., use a more idiomatic form for the error path.

