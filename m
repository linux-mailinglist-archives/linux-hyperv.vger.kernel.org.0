Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F95B74435E
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jun 2023 22:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjF3Umj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Jun 2023 16:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjF3Umh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Jun 2023 16:42:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2114.outbound.protection.outlook.com [40.107.212.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA493C02;
        Fri, 30 Jun 2023 13:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHwNe4tmtvVW1HfJXHfyAk8LCUtHOAzTUdglxS0TjzXrzF079e6j0bYnE2z5YHLkpwSTN7ZsFq+ZJK2fz6TbGWv7rU5qc5FMhhZXUcqXiqfNj4n7A+fB2QU+WMuIg0GSLDnPplBfJqbXs/oM0XIO/p8nokpWMzdoQpnaL+HvjX9hlIMpe1OAJviKc/IraQ9KRmlXfx3i1HIMN4CJO19k4MaQLMTjCt/YBlxyp9Onjuu6b+dL93G4pVwf42KXMcwokSDdNEFCDRmzLGQPL6bKAI0fLjqIXN/i3UM87UwyTHqkQpy8Q2eBaWFvQj7LYoYNM1LVn/4sxzqPqK0l+WrLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/LXdjLZviw/Dru/A7SAWmTkpvtffWO+tFgH8RaF6sQ=;
 b=JAES25uDGI3kfLGD+RD5e2eFwFQhc2yZGeIerpwWvpTTdyc0PtkaXijdtbJ7QVoad8uXsbWRkFVUCw2uwIiQPs0T7j23QJx/PIStuzM9hdQ8xJGgYc6V9HKV0ajti7SyZQLntRpQhaiuja/XlkT7l8OSGLBRV74rqYBg/vhOppmhz4i5M9KsHnPZm8PQ92IrhebhJ09a8XXhGqsLPTug9hjyxGp48I9h3m/Ly9hL2Xk+yDc6+ZnTDEbUkQVufiK66ztjpDt6EBYKRuCqYsDmw2LFB4ep/Fu2pwdQFh8fwGb/rNOzVZpMZ/RqcRdbx8uMWbklJgPoQFVH73JLKcUNMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/LXdjLZviw/Dru/A7SAWmTkpvtffWO+tFgH8RaF6sQ=;
 b=NkEl+NwFnzseaewhQy8XpPYQLUDtGAm+bbecDk5krAgze85Htxs1nn/bGHL+nUsVAyPL5jvE0tNkwVSXD5CP3WP9UVW0QSdtpTycv0Az6RdLOwHVKOeJh91fanzhHvrL27CGYVL0cak24sXozmmum6sHtY3mXC3/+JQYzTX59sc=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by SN7PR21MB3953.namprd21.prod.outlook.com (2603:10b6:806:2ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.8; Fri, 30 Jun
 2023 20:42:28 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::eee5:34cd:7c3b:9374]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::eee5:34cd:7c3b:9374%5]) with mapi id 15.20.6544.002; Fri, 30 Jun 2023
 20:42:28 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Paolo Abeni <pabeni@redhat.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Topic: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Index: AQHZqInuIa+OQxGM80ioo4gKQGwCLa+hejgAgACaBvCAARhFAIAAZi9AgAAzZwCAAA42kA==
Date:   Fri, 30 Jun 2023 20:42:28 +0000
Message-ID: <PH7PR21MB3263330E6A32D81D52B955FBCE2AA@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
 <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
 <PH7PR21MB3263B266E381BA15DCE45820CE25A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <e5c3e5e5033290c2228bbad0307334a964eb065e.camel@redhat.com>
 <PH7PR21MB326330931CFDDA96E287E470CE2AA@PH7PR21MB3263.namprd21.prod.outlook.com>
 <2023063001-agenda-spent-83c6@gregkh>
In-Reply-To: <2023063001-agenda-spent-83c6@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d5ead0f6-265c-4766-af6c-5acf1716d578;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-30T20:37:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|SN7PR21MB3953:EE_
x-ms-office365-filtering-correlation-id: 5e6e389a-4338-4d36-2bc9-08db79aa851c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BxzCuNvJwx/epMrfhEoGxaZhehJFN1D/MCt0vQn5WDvzWFHB7YqI5154q6YDFWKscs8eNio8FQOlb5g+8r+cLbITM0eF+L1UJcGBH6/AT18HChcKSVvXiegzmSr6aWDFv3NMwdP0kZvEXrceYpgJjbcHijAlXQANIEZYTLpbto7aJBkrBtwWVtnGPcsqCY9X4207uDGph96ntL6IMxie65g03UwSgpigMywHu7qS9Z6L4e5sfrJ00JTb7UEGuGoY2GcWilkNzgC0WYpRZ5GcKH4oDc7l0LH6F8oQ+2krbtnZZUWVte01v6v5EEOKPmCQq2KCnmYvSDgBE3ShOkal+Rargv6WVMn3MEp/OAKlmx0mGGsQOSpNDWpOUKqMbKmAZ+8q7qbGE2Jqj2vDnK/8+Bf1ByV5xpd9wnsLsHOsN8gz69nqcg8Cil8Ul17pRszvKDowSWH1mpA3Xu2uA6scOOaGBfsfX9F0TmIHPwSrrIh9t6fJR68bug9JY1ZeIvoMQah+h1VJgRaXYu/qR/eOcbyewmM+DCbtYudnsp+r1/WMH42ayK7wyoAOMTh2SyYPekl4xqG54vNsr6vaaZkIH/nWv4AOAi6ea+kBCNi88aMzqeQXm8h+hnvXvuFWY2O+W3lZs4cCP7bZVb161AinaAt1gQTFQOrA9RjzfglgZ/w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(55016003)(83380400001)(8990500004)(38070700005)(2906002)(122000001)(38100700002)(82960400001)(82950400001)(8936002)(8676002)(5660300002)(52536014)(86362001)(71200400001)(54906003)(41300700001)(76116006)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(316002)(66946007)(7696005)(33656002)(478600001)(186003)(9686003)(6506007)(7416002)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y4ywu2dJ+An7hMmSdTPH4tvsZj2Zw9W54JuOn0KYZTTxnAVRuFZSN7TRvAcs?=
 =?us-ascii?Q?K48Vy/N8CuaitYOpuWG59KNO/Ft2FGXiwTHiVASvK2rottyRoGwNw/ELzJVx?=
 =?us-ascii?Q?vV+Cogt0oG1SHPWcLMeDC0rBJ0z7aKBY1qA1Sfke9z7SHbk+K4Z87x5cVTw/?=
 =?us-ascii?Q?QDk2CuZEgsG5GaWtlSkhD4bx0e0Nd0WCST4JvTioKsBBtc6DI02eHtqEnV7W?=
 =?us-ascii?Q?g+Epa+SKrGpWsXmT0UVYg815AkocYqyJa+WIjBjHswhjKG3KYOBVLeISEU0U?=
 =?us-ascii?Q?Y+8mI4+ZfVqVBAsCPc//LtKsI+JDgYzYD9Hkoo91VeSUx2PzTXm5UY0M29eI?=
 =?us-ascii?Q?WHmdW7kIkNYmPZ13GcKmDZF+R2lROUN0AZbaho2bYxowPoYbcaT+mc+b7d6F?=
 =?us-ascii?Q?byFduHqz21omk/u/YS8HOI00l5bnCCarhjVXFNfKlRXQjBDJJw1+EE9jmCIT?=
 =?us-ascii?Q?daqLURCq3D4uFbe6OUVyRpAyd93aW58sMFbWxMRk34H3pk4/ilAVe4lXKJHs?=
 =?us-ascii?Q?Kc0HPviCu+nGcYdDQsTPZuPgio0YyuAEWyOHUNQqG5Q+xBxGvuQCtdBConQc?=
 =?us-ascii?Q?iBu8ecCF4GO8OVMflHn+M1DoBsQr6IrsSn7PTnV8e1xsNPzKRf/YXP0CCP9D?=
 =?us-ascii?Q?LvuX/Fy3NTXQuFuT/SeseO9yfpCkdedW1pU4G+AO9iE2V8WZP65keLKMSYCz?=
 =?us-ascii?Q?7R+cUaN8tlvmq9IVIWMVBKQDPeiOuCeS4XvrjAeKXsa3KkSncLytr3Ghi+Il?=
 =?us-ascii?Q?JWMqrimKfa3H3R7iXF+HyB51PSN5wsl+EZS1jh59dMJg9ZOfCyjfKYEzPqnG?=
 =?us-ascii?Q?78pFDTmBP4I7Ez0c2YjqwIcspP991m9Gbr31zUDL/jt+7u8FIGfOm6jszX4g?=
 =?us-ascii?Q?20g0MRSLyLFUKC3PIF4F6hkx6SQP1IvrnvI3LjFKEqSB+3VkhHgocTESkqx5?=
 =?us-ascii?Q?w/vx4LW9NgepVoLy2u5begk7+t7+RCud9khH/t58oc3QfwvkdZS0wfb6+TVL?=
 =?us-ascii?Q?vMbcR5jeoApEWeRn8EBvT6aWIp5P0sfJC7TsiAzOvqDl5EPEDvlbTjG9wjx6?=
 =?us-ascii?Q?dQ2zG/YpzWA+VVD2IlZE6GMuJ1QkzxaGiRIF9HDX0tJjEF+99+YadGpRbje2?=
 =?us-ascii?Q?+AD8PhfLh9VpWgSszMFf5gqWioQje376zEKW0p+8J6HtJsRQXUzL2JQ0fZSP?=
 =?us-ascii?Q?Yrd/ePGbIh9aX+jPyidQ/0zX/AUhmGvENg6x5PJYdK7TNKYrblmbEpXXFkL5?=
 =?us-ascii?Q?eJqxr3nykuSw/h2CEQpGPdCyIFaeYwPoctnRAUQGcLzKWfomGXPFbYCKscdX?=
 =?us-ascii?Q?C75qZlGgcPNKFgsfBDF3kF+0undEu3csMoS3hm89sltFqb8O3mynpFWLao2X?=
 =?us-ascii?Q?OO/UhY0/pQTonS5YCuGxdFOf/wF8f1jF6qOUMhM7iPeId7mdvQbiX8mmazcn?=
 =?us-ascii?Q?sIad/zFiK+AJM9UdIZP8441mKfxQfyvN6g3IMXL10mJlKLnYVDxd3Yxe3QpB?=
 =?us-ascii?Q?swpJsq6epqxoZciOC8Gj8MyXJgoSGzIKJ5ENLQ21zASs5VpoFBKlSONM1b/g?=
 =?us-ascii?Q?OmPkHmp7VVEX//ewmCkRWCTuWwsnm7XHxpgeEh8t08tZ1xHpc+pXicfsrfP8?=
 =?us-ascii?Q?pbH5S2+OEW6sWHLZ7f+Da4YBJgypFdCOJduRaWdiKuHc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6e389a-4338-4d36-2bc9-08db79aa851c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 20:42:28.7591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 78A0myNREMo1uGvjddaCcp5r87Ae58GecNavxamyFWFgCYLqj4PrrcvnNiKJTiGxuikjwnb77ajUBR9ve1dpZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3953
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on
> receiving packets
>=20
> On Fri, Jun 30, 2023 at 05:31:48PM +0000, Long Li wrote:
> > > Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell
> > > on receiving packets
> > >
> > > On Thu, 2023-06-29 at 18:18 +0000, Long Li wrote:
> > > > > Subject: Re: [Patch v3] net: mana: Batch ringing RX queue
> > > > > doorbell on receiving packets
> > > > >
> > > > > On Mon, 2023-06-26 at 16:57 -0700, longli@linuxonhyperv.com
> wrote:
> > > > > > From: Long Li <longli@microsoft.com>
> > > > > >
> > > > > > It's inefficient to ring the doorbell page every time a WQE is
> > > > > > posted to the received queue. Excessive MMIO writes result in
> > > > > > CPU spending more time waiting on LOCK instructions (atomic
> > > > > > operations), resulting in poor scaling performance.
> > > > > >
> > > > > > Move the code for ringing doorbell page to where after we have
> > > > > > posted all WQEs to the receive queue during a callback from
> > > > > > napi_poll().
> > > > > >
> > > > > > With this change, tests showed an improvement from 120G/s to
> > > > > > 160G/s on a 200G physical link, with 16 or 32 hardware queues.
> > > > > >
> > > > > > Tests showed no regression in network latency benchmarks on
> > > > > > single connection.
> > > > > >
> > > > > > While we are making changes in this code path, change the code
> > > > > > for ringing doorbell to set the WQE_COUNT to 0 for Receive
> > > > > > Queue. The hardware specification specifies that it should set =
to 0.
> > > > > > Although
> > > > > > currently the hardware doesn't enforce the check, in the
> > > > > > future releases it may do.
> > > > > >
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft
> > > > > > Azure Network Adapter (MANA)")
> > > > >
> > > > > Uhmmm... this looks like a performance improvement to me, more
> > > > > suitable for the net-next tree ?!? (Note that net-next is closed
> > > > > now).
> > > >
> > > > This issue is a blocker for usage on 200G physical link. I think
> > > > it can be categorized as a fix.
> > >
> > > Let me ask the question the other way around: is there any specific
> > > reason to have this fix into 6.5 and all the way back to 5.13?
> > > Especially the latest bit (CC-ing stable) looks at least debatable.
> >
> > There are many deployed Linux distributions with MANA driver on kernel
> 5.15 and kernel 6.1. (those kernels are longterm) They need this fix to a=
chieve
> the performance target.
>=20
> Why can't they be upgraded to get that performance target, and all the ot=
her
> goodness that those kernels have?  We don't normally backport new feature=
s,
> right?

I think this should be considered as a fix, not a new feature.

MANA is designed to be 200GB full duplex at the start.  Due to lack of
hardware testing capability at early stage of the project, we could only te=
st 100GB
for the Linux driver. When hardware is fully capable of reaching designed s=
pec,
this bug in the Linux driver shows up.

Thanks,

Long

>=20
> thanks,
>=20
> greg k-h
