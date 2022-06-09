Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE1544E43
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jun 2022 15:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiFIN7K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Jun 2022 09:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiFIN7I (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Jun 2022 09:59:08 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021026.outbound.protection.outlook.com [52.101.57.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48A633A14;
        Thu,  9 Jun 2022 06:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NawdQEbtyWQudAcIWLroD/QUygcYSWuMKb/WFDMWLQLH6T8x5vHFHW8jZvHhb859e6XPOlnJ5winsE94KIILdCQjLI32WVKykN5izLIn8V1xguY/pga2rvZ85xPDOt9ia4No9mRdrMqEf/FIFowOTEYK/usUWwkPV27fRyiQgLFCmgmQrlGFWSEA9YqfNGm4Sjo2gTn1mdus1MZ5F1wJIwPoHvChTAvR4U7g5AW/R8teUsTxD3Xrm+vhT04uAvwzmJd0QV+j3mw+UGUzY2e5g0LIgxeHmY7ksFfgDFFfJMzt3y1Vd5C2oZt9cF+pOQaXE9j/mj8hB5a59reVcYcFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plELV5Rq3RIZ+9gyTLopQ7uNSlL9yCr5a78D/jPsMfk=;
 b=ayovGF3bRRexDFI+szaf+Hr0gxY17vc+oFitCN+XfSmJerOJFi33phsRumMqKF+X2ALRi4p+xpEm4ui4zwONKFeH4rrG+In2SWasbE8gbA7ssR1vOzmJ5nEDv5MfxeQ26qG5NnkJu12A4eLZOSu/wN0A8C4P4tvudgzsiV9ZbYp+wDHB7OniBthv9+/28CXVbkRU9ETpq6a8/BAi0PoEhoDHf3ppmNcXkQmaP9JYZ07vSp/zOpgueEnuXydJWbTb05fKJF9jDATEi1f37HfO5EBsa+gVDFeRIe+J9TYsUbEF9+wzXGy+mYzPhaieeAZUH0dWwwgYAE0VDlaIMMCYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plELV5Rq3RIZ+9gyTLopQ7uNSlL9yCr5a78D/jPsMfk=;
 b=UyVnan89IwMZueWUp5759xiAcAHAwa2vsWaqG7sJReHVnwicav1EuNKtD1URrQbz+uig7s1Rf1ouEagwu7tjnxs9Emsj4tELXDFqepufLbfbCfi5oji9pAo2LZ13eAytOJzoc1YCL9KXVx4E2vhb/QTRce3SXxt5+P9Ct8Imt7c=
Received: from DM5PR21MB1749.namprd21.prod.outlook.com (2603:10b6:4:9f::21) by
 PH7PR21MB3143.namprd21.prod.outlook.com (2603:10b6:510:1d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.7; Thu, 9 Jun
 2022 13:59:03 +0000
Received: from DM5PR21MB1749.namprd21.prod.outlook.com
 ([fe80::9953:f2bc:5a8b:9d3e]) by DM5PR21MB1749.namprd21.prod.outlook.com
 ([fe80::9953:f2bc:5a8b:9d3e%5]) with mapi id 15.20.5353.006; Thu, 9 Jun 2022
 13:59:03 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Add cpu read lock
Thread-Topic: [PATCH] Drivers: hv: vmbus: Add cpu read lock
Thread-Index: AQHYe8Gfhgj9ktByNUKxLk8ZOUOEfK1HGHkAgAABgYA=
Date:   Thu, 9 Jun 2022 13:59:02 +0000
Message-ID: <DM5PR21MB17495741194946995BA2F7D5CAA79@DM5PR21MB1749.namprd21.prod.outlook.com>
References: <1654752446-20113-1-git-send-email-ssengar@linux.microsoft.com>
 <PH0PR21MB30251360E8081A96F5A33F3ED7A79@PH0PR21MB3025.namprd21.prod.outlook.com>
In-Reply-To: <PH0PR21MB30251360E8081A96F5A33F3ED7A79@PH0PR21MB3025.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0a9be4d0-1dd4-4276-990a-e6e44613ade9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-09T13:44:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d5c6eaf-8875-4b6b-b166-08da4a2035e2
x-ms-traffictypediagnostic: PH7PR21MB3143:EE_
x-microsoft-antispam-prvs: <PH7PR21MB31434984AAEB13D1EBA967F7CAA79@PH7PR21MB3143.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pF2+wMrm3yRROZMGtP3wkcPMqCRxBKWn/4QMx9T9Eg5u71AQf6ov4PSR+12hlvYbpnk6Kh6uRPkQCSsQBjSXALrtZYTV71yqpBsEZEk1qIeDsLexUnXyW90SoXssXy8MnadMmhZ5x5J/jLYK5ZSXGHF4MeB3kLMDttaQ5L74xdkd4uNbrj3pT9vD0CYqpjvpQcVX2iqv97uzK3ozldU7mkOpAHG7tWGrVarmz9FJB5Lx7ZQHrIQ1TzbJIVqh9l2NJEeVM/Y2JZkuEHZRVKkUOiPutSpatYW7BMI4F0UmxNu/4WnG4RtWb9s+FsdBVMBkqjQGjydIuaehCvivav+B/ImIghL1bmRAuDpxrJu/K9EpJ7kGj6UrHu0FI5fXt0kuNGnjDojG3tECWYw180ay/xBaRXELuhPggCJ/+eF1gvR9merRjUCvtBqzzfID9VFGCrNlcUTPBWAkffPmYE3wNcDVI8RlqAv1vs74O6P0tFtf4J8GdqsfiRMKVexPmcRy1CyoHfdj+dmRnFRAttks1ejlzGiH0junsqbCfKfwBWweheCwQ9wulUFUPK5CAVLMFbvIlF072q4cmVRGp8sQru/2ApTYf8oGrM8chnTxMCUMJsEdKGCMtQQD5SNGVGqIvHQHdP6wO3yPtFvABg5xDjCjme4rjlaK8BwqUMqUwkvr50vWv28KU0oU2V2+GXahqI2xJgDfiiY8Be/oMV+COiEbrgalYGBrnRgM5nEwo8gFvDt+JtBI+VxbMA2WlhPA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR21MB1749.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(8936002)(52536014)(186003)(38070700005)(7696005)(71200400001)(53546011)(316002)(33656002)(110136005)(122000001)(508600001)(2906002)(6636002)(9686003)(6506007)(5660300002)(26005)(66446008)(76116006)(66556008)(66476007)(8990500004)(66946007)(82960400001)(86362001)(55016003)(38100700002)(10290500003)(64756008)(8676002)(83380400001)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MNGy1cO3f+nfcPExCVe9+5fruJSaNwDwLqodhHuCvTOOfWx4OuXTZpqteOEp?=
 =?us-ascii?Q?as6xUT1Oa39Ejli05qu4p0Wer9IO3MAZcavBwrkm1kV/CID2gmldNx9m62Y0?=
 =?us-ascii?Q?ttAfvV4q9dYAAavb7Ime3KmczXh0tp7bL3aq2NyDbpN2jUsqZwoVRmChtj38?=
 =?us-ascii?Q?GxGDu5w5RKaKOjADlCrr9uHE4VroVnVdePh87sq2OZuvTul86rqqE64aQqgX?=
 =?us-ascii?Q?bTwzEt/10XBm/2jXCfLU6uKQL+DpNIWcT3WFaNURjuZ2rrzkSZ/jw9Twk2xU?=
 =?us-ascii?Q?KEm3gAkvrkB3A/r9Zuvbj9CPZImtzaxFFZjIiDG/87Zt1cwcYjz9iGIguS1g?=
 =?us-ascii?Q?uN7+QiOL63UFcSkyX5VwO2nOOegV50MeGwB9en2Nyt3ZpRcMWFq1chhTBF6w?=
 =?us-ascii?Q?QXqAfdCFhwesn+Ilt0rOUoiaOomvS3KxIn8FMsGuuvPGQG2AZArCLrCAKCG+?=
 =?us-ascii?Q?3PtAhAswkn1ZxrnH/IOWl7B016JQK/snGLkkXZtebTkJxWXFB7buciXYUaSk?=
 =?us-ascii?Q?ENKVDO6AW/2rbQsL+ZTBGDmX47wALm+BaeYdSWCBBtiWsCBiGs67Oi8uS0FL?=
 =?us-ascii?Q?AXrQh+JGZyICaLCkYJN8P7F3EooBuhykd9YmgtL6P+KJPFxL48d51XEDNZsa?=
 =?us-ascii?Q?Sig3JK8ezSwA76fnMIX6V5W9nJhon1SFapValLNAlakCNxk4B4oPDKF/BBZW?=
 =?us-ascii?Q?WiEZY0C0mKwSNK9GZalEiXYpNKXPn+KvYSPeO1khFf3+egWbR4xa7Yi5Y5Ou?=
 =?us-ascii?Q?vcwYjuDk6HOEJ5o8+Xpj9ekxOgQEg6LH+JNFUEYwhWCzHJ4uoS0LiEipZ/f7?=
 =?us-ascii?Q?hz0ix+51NsJSJICJ17N9VJY1Vzrk4xeJZYXlNJgB0DwpMm5R92IJHoROzhhc?=
 =?us-ascii?Q?SiS/jM6h7ju8V2drTZ5wz53R24TFJ9GqyV6Zxqnnvm8dqzUcE/tMp6gietM+?=
 =?us-ascii?Q?F1u8t7E7zQj0xe4vePmC5gja8y14NIfjTzyqgnFT7cb5bdtNLBu8C6i8hP84?=
 =?us-ascii?Q?UmGWdKMbWJ1OxXA/k3u9M9PmPcoIFdFYGu5oruKR1/7NT/3ARLdiBRwrxpjL?=
 =?us-ascii?Q?/C6MB8ZetRgYMVt25elNf6v6H07+nw2QpDvTvkZK7Cc3GIZjMCI81KBeGm62?=
 =?us-ascii?Q?XQRrMzqXtebgLhNv5D3n5nqsjWoW1WTJQTQsrRlVG22e4UWZAA98CUnfiXsJ?=
 =?us-ascii?Q?BlrsRbQbtZlznZU0KvX0vEoScd9+WJg+EGJQt0TALJ1vO9qyjZbyauYaH0gX?=
 =?us-ascii?Q?fwTRtztDTrStTlu1j3f6kc1NnFZZvhv4e4AZA2bBlPaZeJr2UKO1WPmoP91i?=
 =?us-ascii?Q?yF3v6BiVmXuX6zai4ny3uhNLWDHj81LV4oPFT8Weyr8U8u4EEiWc8zkpY+Ar?=
 =?us-ascii?Q?jK/QCba7PA9DQXu8IpL5PYdmFf3Ysm58yUeg/wFzzjzkYzLluW/Nr2jK72Al?=
 =?us-ascii?Q?9DKPNapAX8Ka+ZT0m+Q6HrQyEAuZ2RCxrFwRo/sbM8sfeE8HiG/1lFMOKz3V?=
 =?us-ascii?Q?ul/kWKmpPff4HpkOJX7CljFMRWO1waTWjhoXsZaYWRjxlFqBPAN8LwRAnE2V?=
 =?us-ascii?Q?PVeARjsKbmxXL8sZl4Dodu9HQuvyC6PmVroSTBZbjUSbGdgjq39E/wbCoUqJ?=
 =?us-ascii?Q?OMI1F92dOkbq3iis39X17cKUeakcVywDMB1ZT5oq5WMLRrt+SbnpgR4ZW14D?=
 =?us-ascii?Q?hg6KjzftLxC8t646i/3SRPRDVe5VoZGbM3aDMcWa3N7rjIpmrlzncLVsx7j6?=
 =?us-ascii?Q?RERgvuJHZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR21MB1749.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5c6eaf-8875-4b6b-b166-08da4a2035e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 13:59:02.9179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CX0zEoANozsptD68/w92gFPhVFYjSC0kKXRF28IKsEt0u08ewudVsCB6WlP0pZ1Rf6p6rFnuc6+v54QXMtm2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3143
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Thursday, June 9, 2022 9:51 AM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; linux-hyperv@vger.kernel.org; linux-
> kernel@vger.kernel.org; Saurabh Singh Sengar <ssengar@microsoft.com>
> Subject: RE: [PATCH] Drivers: hv: vmbus: Add cpu read lock
>=20
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Wednesday, June
> 8, 2022 10:27 PM
> >
> > Add cpus_read_lock to prevent CPUs from going offline between query and
> > actual use of cpumask. cpumask_of_node is first queried, and based on i=
t
> > used later, in case any CPU goes offline between these two events, it c=
an
> > potentially cause an infinite loop of retries.
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/hv/channel_mgmt.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index 85a2142..6a88b7e 100644
> > --- a/drivers/hv/channel_mgmt.c
> > +++ b/drivers/hv/channel_mgmt.c
> > @@ -749,6 +749,9 @@ static void init_vp_index(struct vmbus_channel
> *channel)
> >  		return;
> >  	}
> >
> > +	/* No CPUs should come up or down during this. */
> > +	cpus_read_lock();
> > +
> >  	for (i =3D 1; i <=3D ncpu + 1; i++) {
> >  		while (true) {
> >  			numa_node =3D next_numa_node_id++;
> > @@ -781,6 +784,7 @@ static void init_vp_index(struct vmbus_channel
> *channel)
> >  			break;
> >  	}
> >
> > +	cpus_read_unlock();
> >  	channel->target_cpu =3D target_cpu;
> >
> >  	free_cpumask_var(available_mask);
> > --
> > 1.8.3.1
>=20
> This patch was motivated because I suggested a potential issue here durin=
g
> a separate conversation with Saurabh, but it turns out I was wrong. :-(
>=20
> init_vp_index() is only called from vmbus_process_offer(), and the
> cpus_read_lock() is already held when init_vp_index() is called.  So the
> issue doesn't exist, and this patch isn't needed.
>=20
> However, looking at vmbus_process_offer(), there appears to be a
> different problem in that cpus_read_unlock() is not called when taking
> the error return because the sub_channel_index is zero.
>=20
> Michael
>=20

        } else {
                /*
                 * Check to see if this is a valid sub-channel.
                 */
                if (newchannel->offermsg.offer.sub_channel_index =3D=3D 0) =
{
                        mutex_unlock(&vmbus_connection.channel_mutex);
                        /*
                         * Don't call free_channel(), because newchannel->k=
obj
                         * is not initialized yet.
                         */
                        kfree(newchannel);
                        WARN_ON_ONCE(1);
                        return;
                }

If this happens, it should be a host bug. Yes, I also think the cpus_read_u=
nlock()
is missing in this error path.

Thanks,
- Haiyang
