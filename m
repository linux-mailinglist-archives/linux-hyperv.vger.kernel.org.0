Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC402757E35
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jul 2023 15:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjGRNw2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jul 2023 09:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjGRNwY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jul 2023 09:52:24 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A3012F;
        Tue, 18 Jul 2023 06:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDVozUlfqIJbhqAl1pMvZIP8ODSBGervTFc73V3g/BXqeovEVs9IQFPvM0c7wdjeKXWD3475QxwYzW557ixSRXUJKjVGBtOWE4G9d6v1ejhOSgSPke5Feuqs5ZSHGE6MBb2wMFw8/Oei8abkhDbK2ySEnFBMoczF3pUW3Vejn5dfgeXYRCSW8n0M/6i9Bvjvt9Xm+qD1JblQRh/591Z10FRCo9/H3DIfvDdH1zTwYN2T7CJdojIjgJBrIZCbf3CzPUz+J3xCF2jKdk6rdwuUY1IkeLpL9rNZg72KdSsCDnXOZmM+J/naczc/2jGF3BLt8UKZ7vByvZk7aIOTiA7zCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkE6/25rB3Hdm5NyQKbDGf8j3snz2CR9ctyjBU6sL44=;
 b=X80erqy4WxA1UZ87b63LFMeH4XNCJzBTy6TeDOxiRh4kmVAp6ieenTOA0diKfK7fhywbQFfL2VkeIqpyOS786cXb5jVw0SIX48s5tLPAoCR+DJwH44TGO5zbnt7f1Sc0nbjD15dE4lzhLcu3eVDOwlfJmmCieuxjGnsQw2InzBLlbe/3RO8oBaOUNeY9beHPOzaEBNcQpSGvsuiDWrGadhpP/dJGniY1uN+pQsQy26bH/5RYVF64o3IiaUPCOKlUTZKsyeSVNfvMiA9VT0PxwZsjD9IbpffPIIJs9kzdCKP/KOL1zaej0IK4a7xD2csh5LyfTRwYS/NzvvubL8/Kcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkE6/25rB3Hdm5NyQKbDGf8j3snz2CR9ctyjBU6sL44=;
 b=Cu6NGfElVrVQHU5C8LMqdOzf1tAw5EmMJIMLuJdOd6lAVYYXgHgOOZTsjL7BPYWmggiOSBi/eC/hyYYAWq8bnfZTADq/xwxO2LqejD/yMgWVM0CH2Vkj+peoeOn/02qSnKO9NstAIgnteBN5cVEYuAnasM4lvJ5W7mdIw+MFvFY=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by CY5PR21MB3421.namprd21.prod.outlook.com (2603:10b6:930:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.8; Tue, 18 Jul
 2023 13:52:17 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::1cd5:4b0e:d53d:3089]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::1cd5:4b0e:d53d:3089%6]) with mapi id 15.20.6609.020; Tue, 18 Jul 2023
 13:52:16 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
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
Thread-Index: AQHZqnBMGWxSndAt1U6NS9TBDf5Ag6+huQmQgAXCSwCAF/JCgIAAOxRw
Date:   Tue, 18 Jul 2023 13:52:16 +0000
Message-ID: <PH7PR21MB3116832BC97FF4469A8DAA6BCA38A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1688032719-22847-1-git-send-email-shradhagupta@linux.microsoft.com>
 <PH7PR21MB3116F77C196628B6BBADA3C7CA25A@PH7PR21MB3116.namprd21.prod.outlook.com>
 <20230703043742.GA9533@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230718101845.GA24931@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230718101845.GA24931@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6e5712da-a967-4a1c-96e5-839fbc6eaa47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-18T13:50:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|CY5PR21MB3421:EE_
x-ms-office365-filtering-correlation-id: e3a7f4a7-d9cb-41ba-0274-08db87963292
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Te3tqZstrgovp/V7teB7idXFz0+i09hPT8YnEqw2wSk+NdKZHebIxqR//jclue2kloLz3vLgMRWe/5exMWv8vllc2iXC8ACCsm4VY8XMj6TVy/uUXamwx1iDgk8xaM9LrktaMkuObdSLM1qr+fPRLEmdByRsehvaKOg+3/rLIacQIYplGw0TtKndXUJbMXRM7fWgc/xEH6ErK6Nh1W5AtBdc6qrJGhiyR59PHHKXdOqMfjOviyQrfIGjflv00lZQn8RU5jzOBvRAD+w+FFi+ypLMWGziOrmuHZqRXjLIQSMk/D4ep1FcPoAxwdjzYHwB0EfGPdPoKUnwuOnJ2Z/Wfz2ELlNSdAf9hQhyoYwBExUu5bzGHPHTDhKHcmwgXhTBaQmZrm++rj/d1JlGxb6ZKKoBgPNo4NpxKcQ0h8ZoLdf3txTwCHFch8J/8L/1HdvcD2Nul1n/1H3MXOJj9xXvdtSW6GG2HtJn71NWVV1mBV/qX3cVPmiE+eL0G8gHO2L2B3d3P+UJRgRP7ptD2guMMiSjC29o4zv/6uDYSk9PjLOOKH6T0IOw42mtACSkr+nR+qFyD30EnjtTxg8gh9KgU8fs6zSjlUKajSXimlj3rQxffaOC7ptHg9AqvvoxUBINFhzJZEfTNqElCyv3e4y9rPfPzWLIxmVRrMoemuxobK4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(5660300002)(38100700002)(122000001)(316002)(8936002)(41300700001)(8676002)(82950400001)(82960400001)(52536014)(6862004)(55016003)(38070700005)(4326008)(76116006)(66946007)(10290500003)(71200400001)(478600001)(66476007)(66556008)(66446008)(64756008)(33656002)(186003)(8990500004)(53546011)(6506007)(2906002)(86362001)(54906003)(7696005)(83380400001)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BqvLrhCxZCyM4SVVbORHZZGhWtk/60ETkzHz5HezifH4GZDD4BKeJhXI3fwJ?=
 =?us-ascii?Q?QLMkoHfnyJTwH5pssyNMQrdVAU0pA9SAy0jEBMIqx++a2l0tfc1Z/7zhFa5/?=
 =?us-ascii?Q?8yadrJOeWuT5f9A5c/63ItrxMdBajdmur4uSnHbhjNYRvyoQCTzOAw0bSI8b?=
 =?us-ascii?Q?NwfQ0Zpf3aTsN9SsRWmu1MYLJzWbmCTUZPDTfaMRiYVYycmicBgYoTiRSzS5?=
 =?us-ascii?Q?DWWA0T+Aymq0XsW8DjdjHeIB7Eupqp3DYJ7A1uoj17XBiu1597Z4wCyFVdgM?=
 =?us-ascii?Q?z1bjaWwvSS/rf37qiTycuN2kRSF7MCdVp5CiEzP18LDS8AGLEo7kmcaITb5p?=
 =?us-ascii?Q?U7uQ1LsGgkmrcmZ+Iq27WbmyWvHz7XwS49l7rqLc6D1HTockBU7wv2zD1PjR?=
 =?us-ascii?Q?a7gDqK6kAzMa1+hZe5TufOMVPi2H7i4FbODxKMn3GuMiyvJe6riLHrDyR36P?=
 =?us-ascii?Q?5anQXesrr2ddEvbdkH4uzREHZEZUjvBGy1tXAR2ISGHGJdxt8XLDaK3+Qu7l?=
 =?us-ascii?Q?7r4Ej0cCXURccKrNF/QcJtOP2M3KbzVVt6MODYrBumrXVJ3YmM6fi/xmiNOK?=
 =?us-ascii?Q?acG+ObfoTVPwWYFlu5x4jJM+ql5YBzD/Lh89BFK+V1bfkr2PMZw8fVtfwghk?=
 =?us-ascii?Q?1O2asWhNYuLi3TcfTuV91HwEoEMY45UsekA4BTNWvVn1x2wDqwUeLmcBczF6?=
 =?us-ascii?Q?JkjGEj1aVK1rqTigQlBXFeYgln1aY0eDhh2XBVSw1t7Y/dL1h8zUHvIdBz9B?=
 =?us-ascii?Q?RhkWcdu0Rq8zbqdkWy3PFsdQrrJurtr6wCrg9Iy1TwxB1xJjbD00gKXH+X9W?=
 =?us-ascii?Q?iuQROr/LfDY4pG+9U0/XZ5tOJ0R6k98OQjx3Y58fjKwOklie50RYeZwIObI4?=
 =?us-ascii?Q?AIbIgcx89J5SWr4+WJFg24jkSCTPOsUus3h6LVM7IBqEfCR9tbRmq1WKB88R?=
 =?us-ascii?Q?j8dAogBwTDvfp2TaPO4S+WgUaQ1HjUWcg6pOe4dWFdDNMb8AD9d79yr1dc6f?=
 =?us-ascii?Q?LbEtAwR+spRwJ1LgpJlOQuW7HVsrBdRG91q/QvnS2pIobe8aUAjbxunZYrAq?=
 =?us-ascii?Q?TF/9CVGqg5XzFJO2kMCTj/LBNHanPwt1l3drCfSF6cukzlZJaKTq02KEeP59?=
 =?us-ascii?Q?mbb86N+RWOZL/aH720YnzMBLwec5N9x7ezv8dHei3oShh197TqRH6Dkrk4Dz?=
 =?us-ascii?Q?qWlvxkoYIaTcyzjJAoIeP5KN53LbEiKsl6T58T5sSKVvvQ8ZWHeRrehfrJbE?=
 =?us-ascii?Q?STAT7c3vjY1vRR711JhBaymA8Mls5n66IlgrqvrTNpfufmdnkzZSiBtNaEPw?=
 =?us-ascii?Q?PmBiZJyezblhUu7c4NYGda+sMESc9z2Rgt1LlWehUQxYdl8z2YX/gEjd2SLT?=
 =?us-ascii?Q?2wTqLOEtQAseVa6ZzLduUkk81L86IDeBTxLLUEsXQ7kkDzVRIzd8d4n/EJHK?=
 =?us-ascii?Q?7u+chn+bF/Zze2G/jkfhgQ7BzGdEnkGknice3jhJXNNTFRwaJzekIlJU2u9Z?=
 =?us-ascii?Q?nHuT1xHPFe0fw0fegCxrTIDZMTLgB2SvbHF/9MyrLoW6oVKqxkrGHPSaxQ3A?=
 =?us-ascii?Q?wg8HEba8rXjiMZ2Vxh8BO+YCel+xE+9Aen0ZrYmw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a7f4a7-d9cb-41ba-0274-08db87963292
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 13:52:16.5827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SX9tTAowYoTBgEfc1RRPtLx5POO1W2OxLG5QBNoBLhd80YfIChl+Q9I+51wFQNC50fliD1OblrqXWqXRer+o9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3421
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Tuesday, July 18, 2023 6:19 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; Eric Dumazet <edumazet@google.com>; Jakub Kicinsk=
i
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; KY Srinivasan
> <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; Long Li <longli@microsoft.com>; Michael Kelley
> (LINUX) <mikelley@microsoft.com>; David S. Miller <davem@davemloft.net>
> Subject: Re: [PATCH] hv_netvsc: support a new host capability
> AllowRscDisabledStatus
>=20
> On Sun, Jul 02, 2023 at 09:37:42PM -0700, Shradha Gupta wrote:
> > On Thu, Jun 29, 2023 at 12:44:26PM +0000, Haiyang Zhang wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > > Sent: Thursday, June 29, 2023 5:59 AM
> > > > To: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org;
> > > > netdev@vger.kernel.org
> > > > Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; Eric Dumazet
> > > > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Aben=
i
> > > > <pabeni@redhat.com>; KY Srinivasan <kys@microsoft.com>; Haiyang
> Zhang
> > > > <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> > > > <decui@microsoft.com>; Long Li <longli@microsoft.com>; Michael Kell=
ey
> > > > (LINUX) <mikelley@microsoft.com>; David S. Miller
> <davem@davemloft.net>
> > > > Subject: [PATCH] hv_netvsc: support a new host capability
> > > > AllowRscDisabledStatus
> > > >
> > > > A future Azure host update has the potential to change RSC behavior
> > > > in the VMs. To avoid this invisble change, Vswitch will check the
> > > > netvsc version of a VM before sending its RSC capabilities, and wil=
l
> > > > always indicate that the host performs RSC if the VM doesn't have a=
n
> > > > updated netvsc driver regardless of the actual host RSC capabilitie=
s.
> > > > Netvsc now advertises a new capability: AllowRscDisabledStatus
> > > > The host will check for this capability before sending RSC status,
> > > > and if a VM does not have this capability it will send RSC enabled
> > > > status regardless of host RSC settings
> > > >
> > > > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > > ---
> > > >  drivers/net/hyperv/hyperv_net.h | 3 +++
> > > >  drivers/net/hyperv/netvsc.c     | 8 ++++++++
> > > >  2 files changed, 11 insertions(+)
> > > >
> > > > diff --git a/drivers/net/hyperv/hyperv_net.h
> b/drivers/net/hyperv/hyperv_net.h
> > > > index dd5919ec408b..218e0f31dd66 100644
> > > > --- a/drivers/net/hyperv/hyperv_net.h
> > > > +++ b/drivers/net/hyperv/hyperv_net.h
> > > > @@ -572,6 +572,9 @@ struct nvsp_2_vsc_capability {
> > > >  			u64 teaming:1;
> > > >  			u64 vsubnetid:1;
> > > >  			u64 rsc:1;
> > > > +			u64 timestamp:1;
> > > > +			u64 reliablecorrelationid:1;
> > > > +			u64 allowrscdisabledstatus:1;
> > > >  		};
> > > >  	};
> > > >  } __packed;
> > > > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvs=
c.c
> > > > index da737d959e81..2eb1e85ba940 100644
> > > > --- a/drivers/net/hyperv/netvsc.c
> > > > +++ b/drivers/net/hyperv/netvsc.c
> > > > @@ -619,6 +619,14 @@ static int negotiate_nvsp_ver(struct hv_device
> > > > *device,
> > > >  	init_packet->msg.v2_msg.send_ndis_config.mtu =3D ndev->mtu +
> > > > ETH_HLEN;
> > > >  	init_packet->msg.v2_msg.send_ndis_config.capability.ieee8021q =3D=
 1;
> > > >
> > > > +	/* Don't need a version check while setting this bit because if w=
e
> > > > +	 * have a New VM on an old host, the VM will set the bit but the =
host
> > > > +	 * won't check it. If we have an old VM on a new host, the host w=
ill
> > > > +	 * check the bit, see its zero, and it'll know the VM has an
> > > > +	 * older NetVsc
> > > > +	 */
> > > > +	init_packet-
> > > > >msg.v2_msg.send_ndis_config.capability.allowrscdisabledstatus =3D =
1;
> > >
> > > Have you tested on the new host to verify: Before this patch, the hos=
t shows
> > > RSC status on, and after this patch the host shows it's off?
> > I have completed the patch sanilty tests. We are working on an upgraded=
 host
> setup
> > to test the rsc specific changes, will update with results soon.
> > >
> > > Thanks,
> > > - Haiyang
>=20
> Completed this testing, rsc status reflects properly with the patch.

Thanks for the update.

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

