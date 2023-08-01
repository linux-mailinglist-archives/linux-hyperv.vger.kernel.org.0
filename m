Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C0976BD50
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Aug 2023 21:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjHATHJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Aug 2023 15:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjHATHD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Aug 2023 15:07:03 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021014.outbound.protection.outlook.com [52.101.57.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8201D1B6;
        Tue,  1 Aug 2023 12:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsKmkePaT/J1TcPJI+Tlp29amwCkZ1N99iPwinz1MKBrhM1f0pW9lK7ssZw1tSbsageSwSEp2Zaa59JKAF8fFm2EU6ZzIlxC7tGtNzcz1mM1Ms5MtmZjFyrb1Mejq5jT07W2Zvao3rfxnUtlDtZI0Qtrk2YjcnPNFIJONoQmp+SSQ+SP0oH4W0uybSyOZ1gS4M18C47wwX7DIdvQIMdZRA/24beGE8NSX01DHGHoTQgQDM+sHVO2eBuS6ncKkgYDJhs568VqeW/7wZE9gSzYfcDemd8mOl+rUKDrdXicIyQQQSAihFdH61iTGb8L6T2ivS0ZbEt0WJ3dKFSkVrh2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIeYHDEbl0WgSea9XFzwRB11Dt/4YEUqG5aNbZT4It4=;
 b=n/kBSwEldLKp1dtYfXtB0nt+3zIB5omhpUQ912Dr5BFs+IiE+bf4v+9ItwfDg52ir/2XbWai/Rjd4Gon3vcSXFa0OpEu3FoaibA8O1/RZXxG6C43pwgRJ57HWr+cGQB79+6u7eyO5WWtIIasg99eCGdzAxQ0jwtu6ROCQBJCycUKM3BTCtWGFhmQkn/+OKbqoFP93peVrD6L5a6IpVpF1FxhY4Z9ZOo+FLlauivzZFhTznv1STpueZUKnf/dXxAZPTOOiaunNSG5ij75pUYMcxBrJ0LMWUDaeSnQx6LVZGrLTHnwXEcSE0Gkr5AOAV4Dn72Dx9wn+D5x5a+3OYsS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIeYHDEbl0WgSea9XFzwRB11Dt/4YEUqG5aNbZT4It4=;
 b=DWOS8v+MjGa77tMI9pIckQNnnabJkKthuHiVELc8eNDpSp2Ij9Oo/A4ksTGVsLZVmCRS4AQED29CjFxHVCs/G50VxwQSlwdcMKeS3z10N92Z+Xsx0D/xo6BKph28nMTN9d0Ydf4T5D1kejTEiDF96/6xEh3qQOcAvIIlw3xKOcs=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by BY5PR21MB1411.namprd21.prod.outlook.com (2603:10b6:a03:238::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Tue, 1 Aug
 2023 19:06:58 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::dc6:5ee9:99d:8067]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::dc6:5ee9:99d:8067%5]) with mapi id 15.20.6652.002; Tue, 1 Aug 2023
 19:06:57 +0000
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
        vkuznets <vkuznets@redhat.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>
Subject: RE: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Thread-Topic: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Thread-Index: AQHZwXaGQzAGQ60n40m8kETKVcWbua/PcwgAgAAA1MCAAASUgIAAA6OQgAAGp4CABPLToA==
Date:   Tue, 1 Aug 2023 19:06:57 +0000
Message-ID: <PH7PR21MB326367A455B78A1F230C5C34CE0AA@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <20230728170749.1888588-1-weh@microsoft.com>
 <ZMP+MH7f/Vk9/J0b@ziepe.ca>
 <PH7PR21MB3263C134979B17F1C53D3E8DCE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMQCuQU+b/Ai9HcU@ziepe.ca>
 <PH7PR21MB326396D1782613FE406F616ACE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMQLW4elDj0vV1ld@ziepe.ca>
In-Reply-To: <ZMQLW4elDj0vV1ld@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3fa6109a-49f7-4487-96fe-6f4bc2f7a61b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-31T22:13:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|BY5PR21MB1411:EE_
x-ms-office365-filtering-correlation-id: 3fa3ca57-fd36-4a15-d93c-08db92c27a54
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RKKR/BbXKAm3RbewWggsrQSqygSZVVGcP/VoZGvlGxx2M2GzRkB4p2wseTC27BWCK4T6tOaLmOMuCNWJ7qLcJ7FLz7ZcNlAYWTSTe8HJhk+oEWeVwPLsBBBArSU7C0eXOafuUMegR8n5VwORGTXIjWRMC5V7KThCn+y8mTbm/ePyt++9L+GaP7DsarpFCHZC3GTUkpcj9t1yWHgRZ+DGsmMb093dfjrejGLd+RVhSySrU2V1S1vI8EqVifabsD2xZ8FWsXNEX1nLTiu3phS9cTmKrbfbCNv/Jrf5+qGopRmTT/g9iry3HwFNLpogHldp8ZXiwtOgKRLAVpWsjS8yHC/cmFjXWmJbWFeFgrsFePBUT2eFs90Axr3f+ilvI2p2RzwFrFobryaVTOjcJI9IIRqilOpZS1lsE9FYB9B72/CsW2bQTptgxOwi7JYimoOfObw0Kj9f91g1yVT75aRDADrN4YwopsHdZRC3r5FT7wVxftHoa0wEb3X7skOJkTK7twU2+Zt3PI7t88Reiu+g9nqKbefjhMQAUfnR6iK+98SWwCn1EjI687ofJqipz/JcPKNS378nZ7qGmqO/OSn5BEDECmv209BovfKKBj3qBX/CzIgFaWY88EuPhjGHDtTwoD3VtoCfeBoICoGR6Qa/ULGT81OsYICIAkHvrH809hs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(71200400001)(478600001)(7696005)(10290500003)(54906003)(26005)(186003)(6506007)(9686003)(107886003)(2906002)(8990500004)(7416002)(786003)(8936002)(316002)(66946007)(66446008)(66556008)(6916009)(4326008)(64756008)(66476007)(41300700001)(52536014)(5660300002)(76116006)(8676002)(38100700002)(122000001)(82960400001)(82950400001)(38070700005)(86362001)(55016003)(33656002)(83380400001)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Zk0nqxXh8M1KYJtHiXwa0kICeM3hmQJ9rrs2fUcdPSNL45DhgVLR8JmZHIU?=
 =?us-ascii?Q?y2RM9qN/F3XFUJIKOImRPVr3VAI34wZdiMFBeM4IlR5B4zfSnOt4cLxNngg/?=
 =?us-ascii?Q?egl8btpJxA64c3Q8iOQcFFJDbZUG46g6UQblMotduyDjlRHn6Fq3k8rYD+xC?=
 =?us-ascii?Q?bOI1I2su+hh5t3gWRFiShomOf4f62LVU0/4jvOz/L3ZqTUzW6oilDVRK8TIr?=
 =?us-ascii?Q?JLmURnUXTSBJEE+dVNdAdNAibOue90m5vHfTEBFrZ/PLukPayG9V8pdYisaA?=
 =?us-ascii?Q?HqzNLk8NEKNXyUBioQie3Yk0N+4tknAIPrx+u9Jmk+HcsJecTbB5ww1ormrR?=
 =?us-ascii?Q?aNoMsCGZedcWukXCVsv0c08bB3dtygiqjAMVzvso2GJgFGlFSi2NVRRkaHyz?=
 =?us-ascii?Q?dVAxKwYWhXlk75XSJ7459dzeyoIV0ReNJJMuC06qQ95GcpigOe8Q63SFrFfu?=
 =?us-ascii?Q?XYR+eZ7e2ujHKpmQQFezcKk+r7+Et0qiygJTbaX2I3UPH9G6IGy1ICoQJ5KY?=
 =?us-ascii?Q?4kGVIrwkKXKWzUXXajmmYlpj/YHHi7SeByYve2zu+K3Msogqhsbht40wFuEk?=
 =?us-ascii?Q?WOJWNm0BTUfkvtQisPHNIp1YDp6u+hLxcRnH/lBr25OU6TDhVDWgFehgWjnH?=
 =?us-ascii?Q?LNq9ROVup3gJNqKGkJpfP2qAXFuavFQHiggzAAoMJZYMSDLdSI3i0g5VdWIS?=
 =?us-ascii?Q?BjjKfVb0R9JshPxID3iOoe+ynQnZ4p0igQICsHXbJ0UUED+rcSAatIS2+IqE?=
 =?us-ascii?Q?BASvOiKYD+31w+LcRYowpHwkxG1b4cVcdakwvNXy0DpM4aKwnp7MI0MlAauN?=
 =?us-ascii?Q?9DBHnV7FQOrTTEgD6R3lSlPzZ/uZK6X9UlC+Qar/lcLYYAHJbSMaIF6r7KmF?=
 =?us-ascii?Q?gi+imQKB/CROF4BzWCk2mAgmBsPKZcI9NrWIVS+QtogrBQZbwA/D9xnFKoXw?=
 =?us-ascii?Q?D9K8acfNEFFLDENxYqcX7x1YLPWxMzkgCldjkERK9pFrXMvI46I96eKJFqSo?=
 =?us-ascii?Q?LSeITE+HtbUNIVQRIzjfPMW3/mI1JevO6HFHUjBz9Wji6qWFeARSTt474dxd?=
 =?us-ascii?Q?HFT8BBlc1DoR7eeblP44jc5UCj3kqDkiKlRh5Gmx9aKEZTnLGOdjqoLmAapd?=
 =?us-ascii?Q?qzcN5CQ9hx7PkTXkeGxmuXx90pFeL6IH7yicuavGI8d0jC8Ie5Umi3A1EcXS?=
 =?us-ascii?Q?Rs7dRuSRc4z7hxFJIaG8k2+dBuMCIUqN8ynMMxtDLcbksNEIKfLnp5eoPM+E?=
 =?us-ascii?Q?fhc3sX3VyG0IoHnfwZeTZULMNbWN+Py0pUHV5LjDqveWFNdx1ZmFkeDzo0u5?=
 =?us-ascii?Q?h5odEwSeZaEf7C869/wUrk+5mz8NlgfBmeFp5sjRQ3YxyomsYSklgNSSch8L?=
 =?us-ascii?Q?kzWhKO1LHGfWcCyI+hox5llIJQ+lwWMNSI2WBc0mor/iigpiSQU139aDwCqe?=
 =?us-ascii?Q?8M2ttt4hbHKuw6bBKB9Mgh/5qZlMZ7hZP3cG2k6ThuuE0zH3BvlTEOKAPTwD?=
 =?us-ascii?Q?rlT0dEsjKMsh3/5dD8dlv6BbOOeFmzLtwKdGShECBL2Am0JB5txbVcne3Flx?=
 =?us-ascii?Q?OVZEh5/Uzgwj90+sYfgUuwjkTMTpNi7TLWZvxvTd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa3ca57-fd36-4a15-d93c-08db92c27a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 19:06:57.6548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhhpnonzWZtobI0lnoloFzuDVK5Q6vtI7MtF0i+d1aytMU9ATjStvyHm+5iqPWEA6IcWkxem+UQ59vOB+aXaZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1411
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to man=
a ib
> driver.
>=20
> On Fri, Jul 28, 2023 at 06:22:53PM +0000, Long Li wrote:
> > > Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support
> > > to mana ib driver.
> > >
> > > On Fri, Jul 28, 2023 at 05:51:46PM +0000, Long Li wrote:
> > > > > Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt
> > > > > support to mana ib driver.
> > > > >
> > > > > On Fri, Jul 28, 2023 at 05:07:49PM +0000, Wei Hu wrote:
> > > > > > Add EQ interrupt support for mana ib driver. Allocate EQs per
> > > > > > ucontext to receive interrupt. Attach EQ when CQ is created.
> > > > > > Call CQ interrupt handler when completion interrupt happens.
> > > > > > EQs are destroyed when ucontext is deallocated.
> > > > >
> > > > > It seems strange that interrupts would be somehow linked to a uco=
ntext?
> > > > > interrupts are highly limited, you can DOS the entire system if
> > > > > someone abuses this.
> > > > >
> > > > > Generally I expect a properly functioning driver to use one
> > > > > interrupt per CPU
> > > core.
> > > >
> > > > Yes, MANA uses one interrupt per CPU. One interrupt is shared
> > > > among multiple EQs.
> > >
> > > So you have another multiplexing layer between the interrupt and the
> > > EQ? That is alot of multiplexing layers..
> > >
> > > > > You should tie the CQ to a shared EQ belong to the core that the
> > > > > CQ wants to have affinity to.
> > > >
> > > > The reason for using a separate EQ for a ucontext, is for
> > > > preventing DOS. If we use a shared EQ, a single ucontext can storm
> > > > this shared EQ affecting other users.
> > >
> > > With a proper design it should not be possible. The CQ adds an entry
> > > to the EQ and that should be rate limited by the ability of
> > > userspace to schedule to re-arm the CQ.
> >
> > I think DPDK user space can sometimes storm the EQ by arming the CQ
> > from user-mode.
>=20
> Maybe maliciously you can do a blind re-arm, but nothing sane should do t=
hat.

Yes, we don't expect a sane user would do that. But in a containerized clou=
d VM, we can't trust any user. The hardware/driver is designed to isolate t=
he damage from those bad behaviors to their own environment.

>=20
> > With a malicious DPDK user, this code can be abused to arm the CQ at
> > extremely high rate.
>=20
> Again, the rate of CQ re-arm is limited by the ability of userspace to sc=
hedule, I'm
> reluctant to consider that a DOS vector. Doesn't your HW have EQ overflow
> recovery?

The HW supports detecting and recovery of EQ overflow, but it is on the slo=
w path. A bad user can still affect other users if they use the same EQ and=
 get into recovery mode from time to time.
=09
>=20
> Frankly, stacking more layers of IRQ multiplexing doesn't seem like it sh=
ould solve
> any problems, you are just shifting where the DOS can occure. Allowing us=
erspace
> to create EQs is its own DOS direction, either you exhaust and DOS the nu=
mber of
> EQs or you DOS the multiplexing layer between the interrupt and the EQ.

The hardware is designed to support a very large number EQs. In practice, t=
his hardware limit is unlikely to be reached before other resources are run=
ning out.

The driver interrupt code limits the CPU processing time of each EQ by read=
ing a small batch of EQEs in this interrupt. It guarantees all the EQs are =
checked on this CPU, and limits the interrupt processing time for any given=
 EQ. In this way, a bad EQ (which is stormed by a bad user doing unreasonab=
le re-arming on the CQ) can't storm other EQs on this CPU.

Thanks,

Long
