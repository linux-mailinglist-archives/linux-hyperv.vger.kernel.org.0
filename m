Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD4F7426AC
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jun 2023 14:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjF2Mof (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 08:44:35 -0400
Received: from mail-mw2nam12on2130.outbound.protection.outlook.com ([40.107.244.130]:35936
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbjF2Moa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 08:44:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NATJjTTpfMGjjz43bD0THvECk/Vxh7l2uyJqLnhS9hbB98rAeOA1c8KOPgDv+2wJdndz/4DLdLkUFOqJKiSvIz4WDYjoMTLej57g2OcZImAwQ5b14/RrNASuyMax7ZJlxtdcMeOp5PhDPz+PO/JwsqzFhLQ34kNM3Pt+BO4LM0B/Nf/NZUSpd+Z7EgUCu1f/CB2uTM+nhZQIKT/kNzXSilr+OjxmyOt3Hj/vVkbsdvb0pbdZBPWugXGXBgyoIcbu3nrCG0Sk0bPY8ahmFviaL+X98p4C93lnxwL+ZaDe18ln9+2753PfJdz7atul5jUGf9pSGzJpWQTMEVz6rQ2ErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEs7AwGhLUOSl8RIs8CssvHYOriexhQj4nEbh3pT2XU=;
 b=k6/k+F+Vy+N4eK6NKuIScLIn/BGxLyMMYa3VNUA3PR+GMclbV4/8qulkHaRlUT+/Izzd8c5vYFgouAemzNniav1Og+kp7sAhvxjfpwG/CWIIsUTlv6WTVvOwNz1J40yo6DO2Ow8LNApZoOY3aTjoBTcnXOZmZyZEC2fSP6cW6nI6fyTVb4Vmm8ETx/L0Gd/LzwvPjur23ar28AZOQXpo0T0N99A6km5R8n1MEADDvgjgMzBD/17+72yiiOdarT0Rbs2G0bJvVrmwYbDfbU71EcCOew3DIRpv9vkiX7VY7G+0PvbS2o1RKqSvIgMaa4AlWM93eG7pTsPwXinDCvIrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEs7AwGhLUOSl8RIs8CssvHYOriexhQj4nEbh3pT2XU=;
 b=N9Q3+zwjP9yCwPJqELclhyQWBStbQOjyrSHsyv/tdbFGOM4d04bvOT36DyOP4LWlujTKvEIVoSOA6TbpDTUf0f2F0f+gJNpSGPiM+RVTgA80ef+MljN96rQprngDdL2z7Ez0sTlokGmisUGqXW/uDSUnw0t2IJq5M3YYmbq1i0w=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by SJ1PR21MB3723.namprd21.prod.outlook.com (2603:10b6:a03:451::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.4; Thu, 29 Jun
 2023 12:44:27 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff%4]) with mapi id 15.20.6544.006; Thu, 29 Jun 2023
 12:44:27 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [PATCH] hv_netvsc: support a new host capability
 AllowRscDisabledStatus
Thread-Topic: [PATCH] hv_netvsc: support a new host capability
 AllowRscDisabledStatus
Thread-Index: AQHZqnBMGWxSndAt1U6NS9TBDf5Ag6+huQmQ
Date:   Thu, 29 Jun 2023 12:44:26 +0000
Message-ID: <PH7PR21MB3116F77C196628B6BBADA3C7CA25A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1688032719-22847-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1688032719-22847-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=19ad304a-2c5c-4783-9c07-96fc51ad70fa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-29T12:41:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|SJ1PR21MB3723:EE_
x-ms-office365-filtering-correlation-id: 9644bbd4-c459-41f6-d0fa-08db789e9300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y6gKWkRiT03sbclehpqU5U8VblRWvbaogP2Tyjr4KlAGadyTmqirWKUgI9lIGgCdf2RZY6kpPIfCmKMsVsgGUzOOo2BdT4aYYfXc+qDa8wzazaHNzOta1aryjnSsL+8Nl+gnXiO/afPANOi6LVaFX1GwfyCXdW5zeATr7bmRvJlj2CBlDisHCtCB0ht4stznqhEk8cxWXTYu/rivOq93CgT3P9hSdJxC5GVhB1LRK/VDvu0WoogChBpFeC3h3gu/T0hU90LmyDV8/hwXhXnVZwgFqF8oOtt+IeTsrow0hBem7Cn7gggXTXEfY9eYPBdHR75CrAxjJIJf5XkXZ4CKRVEiYfbFnZNtvBgk7qIzQGOoyQ0LzUx9r6DrBCHqQ205AtkJBpwNi/2VRYE7KPtNj+/RNwnHrK7X4KG0RqeSERQPOAwyyAwvoALbw6AM9zlyrx2cC2sdjAjyvwLraTRFuaD1U6rHtScPpd66KAOdHoXnviJW+dr7ToQV1PhC/KB3FLrlllVuSrDzGr667czfO40CN/SrY42k9GC5TSMWBu4NLXIuDwiq8gGli6kYdtreHNc1gdIQWgk/F+xQqt7tyGFZ0c1JYxFIC+A5fVLwaHi7FY8zM8mvcNstB8BS2aWtFDgQ1axsMj4NPnKiAvwd/8XziBSPui1HY2Py12g/NyM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(41300700001)(2906002)(8990500004)(7696005)(186003)(38100700002)(71200400001)(82950400001)(82960400001)(122000001)(83380400001)(6506007)(26005)(9686003)(53546011)(55016003)(110136005)(54906003)(86362001)(10290500003)(478600001)(38070700005)(316002)(76116006)(64756008)(66946007)(4326008)(33656002)(66476007)(66556008)(66446008)(8936002)(8676002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Df+fZFN1SVtoZ6ux4vHnxUiM4RKuhgxkgSaw46/7zuMWWR3FQJvNsYPXkbF?=
 =?us-ascii?Q?7MSCgpQsInMeluD+At61OlGeAr/fEx/1Ya/uGu0piHYkeEBgrie6jeuf2Pdn?=
 =?us-ascii?Q?LBuL0wfeFYmhAyzuhzRYo6qAptRE0azN4UwgblppRgAvJKrz3tpshv0tjF+q?=
 =?us-ascii?Q?3GGzrAI2ePC13IgymNJBwZ8rDU6ZccznuOwB6aSN9GEh/6s1hpG11x+UOtFb?=
 =?us-ascii?Q?kZOMcyVLVJWbG/7x9cecZ6lmzSSXVX/lggHy7UsyQk614dK9/vhSKvOQID3Y?=
 =?us-ascii?Q?YFIrCa6eLXKD0vo5U2Esms2y2LVNXqiMO8jNmXtjy1luSeSv238cwvAhdXLe?=
 =?us-ascii?Q?xnZmEznaZj6IYCpO3XCie5OYXjftVsPIGpfgDLe+DdjsVFWUjTgrzo1y3xZI?=
 =?us-ascii?Q?FAz/LHZOVALgg9LTmAsVZ0j8fNFvLuLA0bfzZ6MbM/jJevw2Jh/SGIH9Qw81?=
 =?us-ascii?Q?F0MXqxK6ouNx+45nfVPndfSbliwA7mmg+OwOrIXeYlEACv9o+tADiW46vngr?=
 =?us-ascii?Q?gEkRbMjgIEnwo3vYS1yXLoNr4li1g2X8odhm0Z+TgllSmKwQL7f75vFyU9OY?=
 =?us-ascii?Q?EeqMF26lS05wTrygkwVHjI+06IXEvcgcadCsMqiBpCD4avVG1lgb++RebPzr?=
 =?us-ascii?Q?rGpgDt94w3M0ArcVQOEeSggFiOYCZsZ8ENBDJVdoPJoUisJKyTnMNIC2wf4x?=
 =?us-ascii?Q?goxP1kJa4HpgJPho4JA1Cknm6MONxKmlHiTd+etQYDHJ7Z5zg9Rd8ybO5fg8?=
 =?us-ascii?Q?GYEFX68a38J4k4iFOm4zfWkqegefAtJebD7uJfp4WJ0VfONh2zN4L1ZRqXtR?=
 =?us-ascii?Q?xpGvnX3NHIACh5Rcv8Sq9JNqTGetM76hZ5v0BVEGiIHU3WDzOQOt3iEQmBpf?=
 =?us-ascii?Q?EUEuBwlknfIeLBbsUHltldan4Dh78gm7lCbTkeNLcpZsVkol3j10i+BTMbHm?=
 =?us-ascii?Q?LMkkN0lHZ69vEukPPu/6zTtEDC/KfxOLiNckGF8+zS/iJ4Mw5mqv/LgQnBTh?=
 =?us-ascii?Q?ohN+WpXgPBwzGsRwWDxCTF1SDC4htNZgjFso0O1xhRV3Ctdm6uThkqthYQOq?=
 =?us-ascii?Q?d/kReLwljA+rmDOSyV6OWt2YDojdTiHfZV6my8KAD/4O3TefDZOJL+wmrhwF?=
 =?us-ascii?Q?XntnhlXbq3xI+snA3DHBsHrKyskX+o8Px6ypZ1lXAw7w0ietIjGQo9G/tm08?=
 =?us-ascii?Q?IMfRiYecUqXlb0XoUKHx6PZanKA+FHajwiZyHa0taHq7zb67Y3tUnun9YTGn?=
 =?us-ascii?Q?b70Av3V0BlHx4BqEp5v6k64SUed3QALNzILmtyZ8ET/gT4TbpP/8gTS9M3E5?=
 =?us-ascii?Q?GOH5MXiYSAfYy8XNWPQ4j1sBmOKAaeNovcXYQnyzaxELbEzLmir385u4otLb?=
 =?us-ascii?Q?Ke+cw+ZCX2lNuDn8rolswtAD07RiUaG8xHN6BFtjieUGwrhDTWlOqt4JM2Ew?=
 =?us-ascii?Q?QjKQkx+AyRbG3hBUulAn1A4FtF1scZxUA/bukvztupyFKZRUI8x5bfHqE+Ph?=
 =?us-ascii?Q?g/fNSoSHcHdds3JfwlDOWhbAHjY1DJNMSnrciUAywP67thhwGJ9i+Bky+b/S?=
 =?us-ascii?Q?/hwHEvvFmVWHI6+iwbRWKTOI80CxTTKSnxSzzWeQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9644bbd4-c459-41f6-d0fa-08db789e9300
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 12:44:26.9168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSLKn4ubFRR76etuGd9mf3aKgOjcgB3edHrxZFEWUcYVWc+KHTrSMcTo1i+yGkGk37MLuWk6AQxxAI0jjpC0MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3723
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Thursday, June 29, 2023 5:59 AM
> To: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org
> Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; Long Li <longli@microsoft.com>; Michael Kelley
> (LINUX) <mikelley@microsoft.com>; David S. Miller <davem@davemloft.net>
> Subject: [PATCH] hv_netvsc: support a new host capability
> AllowRscDisabledStatus
>=20
> A future Azure host update has the potential to change RSC behavior
> in the VMs. To avoid this invisble change, Vswitch will check the
> netvsc version of a VM before sending its RSC capabilities, and will
> always indicate that the host performs RSC if the VM doesn't have an
> updated netvsc driver regardless of the actual host RSC capabilities.
> Netvsc now advertises a new capability: AllowRscDisabledStatus
> The host will check for this capability before sending RSC status,
> and if a VM does not have this capability it will send RSC enabled
> status regardless of host RSC settings
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  drivers/net/hyperv/hyperv_net.h | 3 +++
>  drivers/net/hyperv/netvsc.c     | 8 ++++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_=
net.h
> index dd5919ec408b..218e0f31dd66 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -572,6 +572,9 @@ struct nvsp_2_vsc_capability {
>  			u64 teaming:1;
>  			u64 vsubnetid:1;
>  			u64 rsc:1;
> +			u64 timestamp:1;
> +			u64 reliablecorrelationid:1;
> +			u64 allowrscdisabledstatus:1;
>  		};
>  	};
>  } __packed;
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index da737d959e81..2eb1e85ba940 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -619,6 +619,14 @@ static int negotiate_nvsp_ver(struct hv_device
> *device,
>  	init_packet->msg.v2_msg.send_ndis_config.mtu =3D ndev->mtu +
> ETH_HLEN;
>  	init_packet->msg.v2_msg.send_ndis_config.capability.ieee8021q =3D 1;
>=20
> +	/* Don't need a version check while setting this bit because if we
> +	 * have a New VM on an old host, the VM will set the bit but the host
> +	 * won't check it. If we have an old VM on a new host, the host will
> +	 * check the bit, see its zero, and it'll know the VM has an
> +	 * older NetVsc
> +	 */
> +	init_packet-
> >msg.v2_msg.send_ndis_config.capability.allowrscdisabledstatus =3D 1;

Have you tested on the new host to verify: Before this patch, the host show=
s
RSC status on, and after this patch the host shows it's off?

Thanks,
- Haiyang
