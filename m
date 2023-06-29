Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C4C742BD7
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jun 2023 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjF2ST0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 14:19:26 -0400
Received: from mail-bn8nam12on2112.outbound.protection.outlook.com ([40.107.237.112]:23265
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232166AbjF2STR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 14:19:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mboB9/Y3gw2Sj6FvAGbs8HMySbrb1HG4aw3kuD3Gjy0VmTBeBuV9ds5kOAMViXwP8fIDgm4ok836QYwnSKTQALDyjjm+z35oN2bmsLgy8ZU49aKlq460XvhKHO71naZt1Fl8chd1PY9n1lobPJsaEFCv/ktv+6RQJ2W+KEJLJG3JYE6nKl0Ax0NK1ZHKZEI21FQdCn3uESSpqzxuj3gotHXKLOjhUG6sUjGXGF1lllEeRzcdkxxGb60xDg8DpEBnirAg6aTII0ZU1fH3IsVguBKLAyZaDV9hLNwV4gjYPij6lXBPrO7fIuzY8Gn7owKH2CclpytsWfl9cAlda1sS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3Dl+YL0PCQKfqxfcTrMbTXYDL+5DpvrmfteLqndCHM=;
 b=guCWlLAQA483WLfeCW+z7xohsM3tlQw8iw/1y38+90ZD2wr8o6GkM/Xaos61E5z/My0TMa/t9ZxQiSg8O3HpybLTglrvZJiNLV0N0ls40lBOGNQpeeKsf1QzZr2mQvAQOsuT+ADs3fS8IZM0MgpAbPHbew0riDojzDCZPjlRxDz5L88HuYIyAaWKR2NCiVTdjW0ybM4G7kOR+lK+HkSp9l3ZUcUgshUwlN74CH0YMULBF8hG04DiH2J0YDrPegU3WWpNycwHiWZVlVbLUZzaR4Nlsn5LaufbpETmI0c4gyjnxW/2pvtFptmzt4EybUpT5R7TF+P971I2l7EgLI07gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Dl+YL0PCQKfqxfcTrMbTXYDL+5DpvrmfteLqndCHM=;
 b=aq43z4/WCzNvP7DMojdFl8Yk1+HotNagy0LVReiSZexyZFInhhJkF1ctGoru30feFmu4AlwopTAc6g9LqmIwSkY7IXNBHlpUcwLr3b2lbeARd6tLhbvY8/j6Zbu55bknOGRMY1FVyP34RSZ6It5DQj3Nbx4v5+M/rLfDUdkUCyE=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by DS7PR21MB3774.namprd21.prod.outlook.com (2603:10b6:8:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.2; Thu, 29 Jun
 2023 18:19:13 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::eee5:34cd:7c3b:9374]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::eee5:34cd:7c3b:9374%5]) with mapi id 15.20.6544.002; Thu, 29 Jun 2023
 18:19:13 +0000
From:   Long Li <longli@microsoft.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Topic: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Index: AQHZqInuIa+OQxGM80ioo4gKQGwCLa+hejgAgAB9bYCAACOaAA==
Date:   Thu, 29 Jun 2023 18:19:13 +0000
Message-ID: <PH7PR21MB326323DE489A3169669EBDAACE25A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
        <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
 <20230629091129.19217388@kernel.org>
In-Reply-To: <20230629091129.19217388@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5d16f9ba-8b78-42de-8cac-9a99bd56e784;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-29T18:18:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|DS7PR21MB3774:EE_
x-ms-office365-filtering-correlation-id: a32ea673-e23c-4584-9713-08db78cd578f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iFDxUIKQcggpmsBPnZjsHLORLwN2Od26kYRsYw+X/Mt63BAgj8WnuxLDkVlhmcS+XHXF//hTzQ9wYYNn3RVsrTuHvGbZ7Jk/hA8zAC8fsKCWJtufJ6qasr1t6L+9E9q0KlJemufuRa3ChZFdJkBNqjM0RU+5xWCyVOY2sgpEAeHypn/nYK+QBcN+7nyfr1mgDh5rC7jvhkkcGLvIHWyxvmwD3EAYPyw6YPnIqYRBdhApRsqak/K8cJMJ8n1hj7W913AGwf318/Vudp3RZ9UI30REEwByTh7q+teLdYfaM50XNycjCdn4aYyKFb6xY09K5Jh8ZzqwrVZCW+qHF101gC0TYpflyagVrlOywiDL3RIpcQzR5BmKohOpnoshUxEPFeXood4ccRPtxtfmSuEfUDKW6barV9Q0joOJp9bFKkiHlUPr3yhiWfbC5qLUV7hV9kxPJwC+lhxgLqdszNShP5/jhubMbLSt3CNgEKDOHKuCh7RAa9Ljy3wa6CnCzsBJad6gB/nUh3O92XWvOLhasn7uGwsFpIxI5OfKUVy9PiuYOZrV/Vvu2WquIywkJifZF0xRChIzHsgp8EypwhSgS2ZD6DGxNz1CAywp113GUTwVr+iGqROZMUT9rxItrjq1aKflrm3mZ+cU4KpJD0qa4xKXiHDuYVZMWxsqdgoxKlA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199021)(122000001)(6506007)(64756008)(66556008)(66476007)(316002)(186003)(4326008)(9686003)(66446008)(76116006)(52536014)(26005)(66946007)(478600001)(86362001)(8990500004)(55016003)(4744005)(82950400001)(7696005)(7416002)(38070700005)(8676002)(33656002)(5660300002)(54906003)(82960400001)(41300700001)(10290500003)(8936002)(110136005)(2906002)(38100700002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?swpD89+GFIlv9J2qnW5z3bQnyk2XDr963DYO9qqHoOcEJtwth3z4Qet548nh?=
 =?us-ascii?Q?p3/cdZl61/8JgWySj/i7cBoh6PPa7+A/nSwcNrz2S3J2zGc0FQG4Y2FcHnd4?=
 =?us-ascii?Q?vMZwfbR/BK5gg+vEc7Pe4IqN34Bid987nDAz7rEbV+HDtgt+CYlvZuuiNzn2?=
 =?us-ascii?Q?DtFkASZyz50l6QfP6VqDRXMLhGSnf9e/mEBPf0Yem5b0ZjtvelOs4hmpi7vK?=
 =?us-ascii?Q?Cxu1sc2lufz7jmroLgIAb45kJVX0iEj0hJ59TtVzPBZLnMlkVL6wqd7jTV3X?=
 =?us-ascii?Q?f5lNnhHog5Zpllc3CVgwzJEMhepz/ZBmVp0/951Oyypr3aQFwBy4jF7rexYC?=
 =?us-ascii?Q?Q3JZT1Zre4Kvlf72bOXh0cRF0Pqx56krm6ol0k5HEFCaW4DgyL/mPy0Or2CX?=
 =?us-ascii?Q?KwChBprIbcpS/8UNbdvZwlwhxx1oi+J0NrpRWLtjcrfT9DRWYq+jHSPWCdSh?=
 =?us-ascii?Q?DnsP9s1dEDKwvp1+l3VJP4HUekg5SZ0cUvFwAF0CqR9RCYX/420enkNT1BP+?=
 =?us-ascii?Q?PjhvudNA3K53+kTbbd+kzOFh+t82e4SBNbFXnHDbVdiKVQsC+91hAdYx/DNc?=
 =?us-ascii?Q?+ol224Cx3+arY5FXtaNdyIcFaXJwYKCCw9q8pL0L15HqBFylFkxh9ZNdq5ex?=
 =?us-ascii?Q?ULssYoW42wwlkgs/XcM6Xncuw3xBUWItSnXCeJWiGtttzgO/LO+/dRD4bqWZ?=
 =?us-ascii?Q?lHsJjaKzGUqHy0VHTf5nAwPsRAT7ovTnH56ml/FmeYXxcZa6RNJnI9qK6P5W?=
 =?us-ascii?Q?4fXEBOvmiePA1aaFdCZTsgMLzVk2YTmqq5Iq0JCOJE6jTHKFFRZpwP8TBBqN?=
 =?us-ascii?Q?6SvEkioX7NuqaAYVpPq2gX19Ukhi7LpLvSVaTT4OamAQRc6plNSVfyZvUicc?=
 =?us-ascii?Q?wGCbp6Y3yemgBSEoI/4wA0iZKi3O6Dd+Q6bOIJzJX4CziAEQ9RsAtOycw7cq?=
 =?us-ascii?Q?7Dqvz7HVhtaPi4WbqkI6AD484ekegw4r3BSuCm5c9ZuBzHioDcTQSEtL1c2T?=
 =?us-ascii?Q?lVIeC98kOlBVq4Y8xSB6F6ATjY4AVTEDa+cJI52qE3qcwWdd6F4rYDa+LvJ3?=
 =?us-ascii?Q?dzmjtukAKMKTmz6MQDtCcYVSbVd8rBYj1paT676E2M/ChIP9awl9Ap0SlemY?=
 =?us-ascii?Q?e6Tv43iVDE7YEBfuDRGbIRJINi2II7hGbAYpwXhmnStm/5tLJyx7sFY8anfj?=
 =?us-ascii?Q?1zl5H/BNoTC7jaY7mLM2NOJlf/ZWqFSbXNXTcSXTTT1z6oEgjuTt3Wxmq/VA?=
 =?us-ascii?Q?tZ6vLGcDaST5njqqRUEQ9Em5TZ+fYIOXVJhTaVjbVAgjNLdvRG3nMeoGBMlI?=
 =?us-ascii?Q?yXPXR6gSYC3ihE5G/6UT/isqJGBB9YjFX6gw10qPhI0vMBHxtuz+RljEJ5kM?=
 =?us-ascii?Q?r+28MiRBTKiCrL5IrcaXWDQnwBfjzpXiurqviXbYFjDxjXN+N0X/css6noCd?=
 =?us-ascii?Q?R/r4KGFv0ya7XvKV+NMeekJUmsdpWTmc9TtmwD+Sfo1eT0VmuY0f/l5sF5Ur?=
 =?us-ascii?Q?mBmx90jpeK0Rv1aZER5KYtY4r0f7UZa5In4SCLgJ7ctIeIKQJV9f5rl2Vjc9?=
 =?us-ascii?Q?5kRLTjdd89zPupe5ys8ut37yFwL7r/3y7rx5JgHN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32ea673-e23c-4584-9713-08db78cd578f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 18:19:13.5210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q58sYIrSBPf/WR1YwHsgmMNmtPqo8x2T3cCQ0p9zwa5yr8vchxnidnvdcXRu/JROhbEwNiuQevZbpIxsKQKnaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3774
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on rec=
eiving
> packets
>=20
> On Thu, 29 Jun 2023 10:42:34 +0200 Paolo Abeni wrote:
> > > While we are making changes in this code path, change the code for
> > > ringing doorbell to set the WQE_COUNT to 0 for Receive Queue. The
> > > hardware specification specifies that it should set to 0. Although
> > > currently the hardware doesn't enforce the check, in the future
> > > releases it may do.
>=20
> And please split this cleanup into a separate patch, it doesn't sound lik=
e it has to
> be done as part of the optimization.

Will do, thanks.

Long
