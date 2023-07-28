Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A447674A1
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jul 2023 20:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjG1SXh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jul 2023 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjG1SXg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jul 2023 14:23:36 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-cusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1F449C;
        Fri, 28 Jul 2023 11:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzrNpdHddacqED8gouDc/k8x/ZNIkiYmzLMM9jxLzSYtKNYcaPYCqNnvhb4uwYx847VgbnusdiHo6odHqwZnqxuppzDDPuD5wbPNvRvX6/lqwr8n4j4FrJ7UIDqt/xtd/6AFPLZHoLg5WfODX8NF2KjXMMiNX3DMof1ZRqn263DqZTyCVPzYQHZRXHHoeNevLz6WQCLWww8fJGarHgNNlAoqSHRilboZZ6fyIHz345pRTBIgPy72XvI2syPRdQzQKK1bEiz0CnN9Edv6I/Mi0o1x/S4jCUwbDEjKP0SjPM77Kak6G/YEViUBlYMuJ7KZI7A4VoArcsjtBSAdAPRVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yH7rAlWjuj7pBjULNGpRlcTPWnbt0Lg8/K7lQTjo/8E=;
 b=HdoWMzEaVd1bhVOGtfCrtOOdAYQKp8VvKGGA8z1nCHeDAVaBwgZBZ5Y5zHgkz9g66nOsU1TfmxA00HdtN3TpqiI/XinlJIFfz65rk8cUQ1tvoDZt8UcUjadToZF+aS5ax4l4nyRL6YOzSEC8DRRfVZJTOrkbiQLwmyBIOPwBQcqaRjbd9wZoOcTZX2mhNrQ/VXwPVzg6epA7keOQ8bzF+GE2DhS+lDb7UVD67Fsyefg//le6E1GVgbthnR+CqjbWbGxxd1XexjWMrlo133RKx7dIC+h0SPAhQHXKLdVx9KZgFjrtSAAjTwfN0r/WRsqoxNynKZXhjJgZws/FC/wofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yH7rAlWjuj7pBjULNGpRlcTPWnbt0Lg8/K7lQTjo/8E=;
 b=Bz60YWgEYpafJUfgbC8YRYllpa5a+tLpZnS4Ps0cgacaaDDK4YuAUq0C/SOFPHS75qjoA8ZQjEoVMZXeTnq+7xEzpXNcimmtY0VZqrgvRf4PLJ9em8o0RFUI8RIGub0L6Uvr6Er1X1FG6yAmyaSfOdGg4dJQO5yhzVinwK33Pww=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by SJ0PR21MB1920.namprd21.prod.outlook.com (2603:10b6:a03:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Fri, 28 Jul
 2023 18:22:54 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::dc6:5ee9:99d:8067]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::dc6:5ee9:99d:8067%5]) with mapi id 15.20.6652.002; Fri, 28 Jul 2023
 18:22:53 +0000
From:   Long Li <longli@microsoft.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Wei Hu <weh@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>
Subject: RE: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Thread-Topic: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Thread-Index: AQHZwXaGQzAGQ60n40m8kETKVcWbua/PcwgAgAAA1MCAAASUgIAAA6OQ
Date:   Fri, 28 Jul 2023 18:22:53 +0000
Message-ID: <PH7PR21MB326396D1782613FE406F616ACE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <20230728170749.1888588-1-weh@microsoft.com>
 <ZMP+MH7f/Vk9/J0b@ziepe.ca>
 <PH7PR21MB3263C134979B17F1C53D3E8DCE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMQCuQU+b/Ai9HcU@ziepe.ca>
In-Reply-To: <ZMQCuQU+b/Ai9HcU@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ec94bf75-0431-48b8-a324-37f7173c68f5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-28T18:15:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|SJ0PR21MB1920:EE_
x-ms-office365-filtering-correlation-id: 7cd7b850-61b9-4ce3-17ef-08db8f97a8c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HUWCI3+OnddbdLRo/XU/EKvFWzgyQMb0MDJcw9oG19+p90Zb9Py65G85N3ivnLb9g8DpDrCnQeuaiTJfvWOkovU8bIWfgOnFOnFrJEgCAAeIUlawsQG2CA63PftWMj4vm+sF1QxSmqLOS6SB5ly3klOUZQ1o15G3fgZf67k6RJ3jHpGCu2pEgnP1zpRPFEZHRSjBj+8X73tLKCph1cmLSipc/e5gZnvkqkV9vdyZhBwF3HJVClxP6ZyDUlwFL33w8PZjL2wqMtiirq2EKbo+mn5aslK/wdc+KmgxtJ7qXER1ZKgoIUuLXrz4/QLwtDHgflouXDwJMyyM0uANeilJPwr5aJHR0JhwdzpgH8FMGOwKxArpRJR6amwSX8yrhqAX9JZTXri5ovadyopDSYt6dsfsAsXAMtdlgAYRGgP0WD1I3/+NjDzqaZZzXz2B0768JHksKmQx9nZM+uhIFNp518NNVnJVT0Cn3kqbzwtRClRn/ZRL6e3QIzXmfiw8qpG9/Q6QRRvxg0KMe58JEd8oySzIGqSed1rrNitlFvbmIhy0bOw9MnFi7luxL2/g+vBGdvU6gZi4yxCTFfeiARf7eKiWlHupXOhow09QvBH1VSPr6eyqr3r5CfK/dlgiFbGumew8u5pnfHvYX/T+da+zpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199021)(8990500004)(66446008)(7696005)(966005)(71200400001)(66946007)(66899021)(64756008)(9686003)(66556008)(66476007)(38070700005)(55016003)(6916009)(76116006)(38100700002)(2906002)(122000001)(54906003)(478600001)(10290500003)(82960400001)(4326008)(82950400001)(7416002)(83380400001)(41300700001)(8676002)(8936002)(52536014)(5660300002)(186003)(316002)(86362001)(6506007)(26005)(33656002)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wvLrdSyNDklSlLfMT13Fqp3LFOtBumR7i6cX3dCJAAM8jDytFq9SHRSj9ZeG?=
 =?us-ascii?Q?Ic0NQHhGUbaL5bL/1VisZ5vlPynnQmfky8Gl2kBTFFOIA/Zo1DU6bh2x/ZMe?=
 =?us-ascii?Q?OhlEHn/V7idmDtX72B2ise/p2k7VZA9MRYD7k0Z/P4/OHfI/2M2GmXtRl1lr?=
 =?us-ascii?Q?iDU5FjC46SgBXQxyEl5bCyOOyPNEzsZgySMdsXGEVCzYfDMxiGvUaTbkU7uS?=
 =?us-ascii?Q?ywdTHZH8d9/YtUPnzFBLWvrT6xRc7dzfRzSOcZhlrRfEcgLfBdhwhoSNcpfA?=
 =?us-ascii?Q?MResoX12MQWBVsl1eeYfBVsiubNMV3qNectDPWfeTd5uMQshKa01nhNtK3Js?=
 =?us-ascii?Q?M/DwZMkwXsDq06rZQMeosAaEJsYoajdR42Nsb/nJaGy5v8X4wv7Pa+G9ddut?=
 =?us-ascii?Q?XbjhV3x2MCwBOx/ROkYwyS6L0DRzHIuaQ2cBmGZJJ8aaJVxcgCLFynPeK3ZZ?=
 =?us-ascii?Q?1GsJydX7ppaNFWbwiWCjJiM2gXhph39iRMj30gjx1nKCUMSzycOUIoHFEOvG?=
 =?us-ascii?Q?s4WrrPdLzA0bAIOosv3pwRtIWvf4ah9D9xo8XpAyYgObc0+2Re/5m0DatgRW?=
 =?us-ascii?Q?UIqxk5mwMZMoqajr/knpWvTwtyFqmlotfQ/eReyWEpz1MEZVpShgXeyY23zw?=
 =?us-ascii?Q?9NKTI1CZ4x+euFD2c/ogn4r+WciAR/Iaiei/5OhGkm1f8o5SsAIMZoIroke3?=
 =?us-ascii?Q?9Wl65VPT1BLyK/N9GcsTnpH2XR5zG7xB6pLuE20QI49erEPQD3DW0cHxNL6b?=
 =?us-ascii?Q?uZr+dzFMJLTpJV5IHlDJ27D10+J4DMQB1oqfKzU7r3/4iTF/qkNOhlxcvwl1?=
 =?us-ascii?Q?CpoFLhUYKzJq+bLb0BZkm2s0AmLw76kNeSd57Ji77NzZDSUxOsoj0lGryjAr?=
 =?us-ascii?Q?ylQGpWuTaFhBOZgChuvDLSxy0aDdoqZQ+P5pdiHmsN/fr/Yj/lddZ7d1Z1Ks?=
 =?us-ascii?Q?adtHzcRabeZtqvvaWcjxjFmq3QmivoBe+IOE7if7cddOppMGFs/hJTPWiMxe?=
 =?us-ascii?Q?kDG6g/qed7o9hqtQ2DVhYR2YwuBBjoXWUhDdEurgCQWfLj4aWJW1Th5dxCgJ?=
 =?us-ascii?Q?Lo0zV+9+LT4NGfO9HzpsaBWA3FUQHqccRS9+dsZY2Ti4l6GR5UWjfjp1X5y8?=
 =?us-ascii?Q?Lxsb+1XonkfPMOK/UtsZvgmY3EvJ9UuquDn9Ymr84O4xtnxNw+ZPc0M1epbk?=
 =?us-ascii?Q?tUDZ6h1KiOJh4WFXJgC2gjCe/zt8mpHjVJ3JSTFUaFAdsgdVVBtra6KPcabX?=
 =?us-ascii?Q?D2R2dG7xUmVTLwzSPRkG4dNqWvnnCWuh9jjhXEbQuI2hQy4SKORerhV0ISHL?=
 =?us-ascii?Q?xGCAFnyAWIEqzurvJGMkBC0T77jLKe9hGfowllRePdKdM2mpA7jVv8iAKOqB?=
 =?us-ascii?Q?LEUDz5DB3nz/4cn6czKyK8RWuCPNXglS2qSiK1Vf6ewBe9EDph1cSxLgvufm?=
 =?us-ascii?Q?DoajiIG6Mv9dHn6+XdQxt9jtrZo5P9NnqbkfE2LvvscV2+X0Oa1b1Jj1YRI2?=
 =?us-ascii?Q?hkmMnpyVnDuJ0J0WdePHbkAXpxPgdy3rOCxy78otyixBfdeXTk03WO3eHfuI?=
 =?us-ascii?Q?PmKjXg8wE30Ef1/3XfwklDC/RvYXYhBzje2w2QHX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd7b850-61b9-4ce3-17ef-08db8f97a8c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 18:22:53.7490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKJAIW4R+BlDEbj5XG1hF2Lvumd/VvHCVxvy9uw3GyYXEdqCyF6/R74H55x5bA5QMZyoG0a+uRaD0yAaapxzDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1920
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to man=
a ib
> driver.
>=20
> On Fri, Jul 28, 2023 at 05:51:46PM +0000, Long Li wrote:
> > > Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support
> > > to mana ib driver.
> > >
> > > On Fri, Jul 28, 2023 at 05:07:49PM +0000, Wei Hu wrote:
> > > > Add EQ interrupt support for mana ib driver. Allocate EQs per
> > > > ucontext to receive interrupt. Attach EQ when CQ is created. Call
> > > > CQ interrupt handler when completion interrupt happens. EQs are
> > > > destroyed when ucontext is deallocated.
> > >
> > > It seems strange that interrupts would be somehow linked to a ucontex=
t?
> > > interrupts are highly limited, you can DOS the entire system if
> > > someone abuses this.
> > >
> > > Generally I expect a properly functioning driver to use one interrupt=
 per CPU
> core.
> >
> > Yes, MANA uses one interrupt per CPU. One interrupt is shared among
> > multiple EQs.
>=20
> So you have another multiplexing layer between the interrupt and the EQ? =
That is
> alot of multiplexing layers..
>=20
> > > You should tie the CQ to a shared EQ belong to the core that the CQ
> > > wants to have affinity to.
> >
> > The reason for using a separate EQ for a ucontext, is for preventing
> > DOS. If we use a shared EQ, a single ucontext can storm this shared EQ
> > affecting other users.
>=20
> With a proper design it should not be possible. The CQ adds an entry to t=
he EQ
> and that should be rate limited by the ability of userspace to schedule t=
o re-arm
> the CQ.

I think DPDK user space can sometimes storm the EQ by arming the CQ from us=
er-mode.

Please see the following code on arming the CQ from MLX4:
https://github.com/DPDK/dpdk/blob/12fcafcd62286933e6b167b14856d21f642efa5f/=
drivers/net/mlx4/mlx4_intr.c#L229

With a malicious DPDK user, this code can be abused to arm the CQ at extrem=
ely high rate.

Long
