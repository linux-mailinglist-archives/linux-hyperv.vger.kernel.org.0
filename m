Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080A27673DF
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jul 2023 19:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjG1Rv5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jul 2023 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjG1Rvv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jul 2023 13:51:51 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021027.outbound.protection.outlook.com [52.101.62.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4E83A81;
        Fri, 28 Jul 2023 10:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9W79hvolDWPnzLKT+4zL0y+rtvKBan1BYAmM2fAfi1aspYyrTUyZCkJSU4URIaKUHGwieLc+ISyTcDuAzXEkHBNp8Rih2FYAcz+84sM7RDxnayhOY/ge6EuMDdrEtFmfXj6CqtBDfgvvaAwTurB9Tjj6HThhgA7Qf89H4YOcCRI8buQI+x2H3KpYeOygbyro0HLHdqhc9c+q/PLNJLOTOvpeev1EBJH4EJF93QxLa6QwQQGPcI2J2smiwJQwJ4rWgcszZDJMTul1QSSQ+Hv+BUXyyHOW0tsC5SIBpFD9Hj7ul1CQOLtkdzbtySZUXtbRCSwOfgTViAKLA3negophg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozrxbQUaJDe31g3sbwR4Ed+z5W+XOcgutRLd66W+XWE=;
 b=bvCZHJC7oSqJU2vJzBxEp9FY4yM2/tEvPIIx6QUmsCBy3sdX1vlIlkgrpkZ/twrqg4EYXKhZDDf9XqcGC0TxlC9QAfPwt5KCu/hmXkRfNUQNYqnbIdSgM87fEm4YTJDE6gOMXDnE5nYoMjbBio6oORaptoxGtOfxJEUsvKGLYVF1ilEat7SgFwNl7kzXOkzitevkC7xJuUx5NsYFW70pUNnA0+Cg7bKi2HJTCkWW3lRTtWuy0MDbv/pMrYMAjzC8B6ueEZFSUwEvcfogpiqg9HFr6HByNfyJcZRUILPA2vWPa2v3RYxDYGJxMLQ06Ptly+3qqLdP/51HqWeEPTK3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozrxbQUaJDe31g3sbwR4Ed+z5W+XOcgutRLd66W+XWE=;
 b=BEvr+96aVZf9+8i1Pg2zvKxxg3CjZ9xRFxSr22O/CMvcotB0NAS/Pyj+L0Zd2kKfmA9Y6emIjdB5dbu/rrpOw7sC49oCmK2EqFRCtrxGxDsY9jZCcgQcIsYib2+Vo5VszcmqR4f/51il6S8wPRQMuEiV7l9lDxneAdeJYY9BNRc=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by BL0PR2101MB1314.namprd21.prod.outlook.com (2603:10b6:208:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Fri, 28 Jul
 2023 17:51:47 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::dc6:5ee9:99d:8067]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::dc6:5ee9:99d:8067%5]) with mapi id 15.20.6652.002; Fri, 28 Jul 2023
 17:51:47 +0000
From:   Long Li <longli@microsoft.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Wei Hu <weh@microsoft.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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
Thread-Index: AQHZwXaGQzAGQ60n40m8kETKVcWbua/PcwgAgAAA1MA=
Date:   Fri, 28 Jul 2023 17:51:46 +0000
Message-ID: <PH7PR21MB3263C134979B17F1C53D3E8DCE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <20230728170749.1888588-1-weh@microsoft.com>
 <ZMP+MH7f/Vk9/J0b@ziepe.ca>
In-Reply-To: <ZMP+MH7f/Vk9/J0b@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e9a11749-e2af-433a-9859-53e2c31ec0b0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-28T17:46:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|BL0PR2101MB1314:EE_
x-ms-office365-filtering-correlation-id: 9eab0af7-35f0-4f53-ce85-08db8f935017
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 88xmqdfsevJd09vCDX3krmmaHsuLRXU5IYqLGVo3YEkJbdN9/Q3mQnOoV9FwzeJBNR5UpjzSdpY6T66eDDPo2zFna2lvGr1xorT9tDnYp+GxAIJcCV/tYY/BSfKQeAMNpOIQSVTsLi0CGPTBcR/slKb3RaGJWssMGqWZtVgsygZ6OylErmIflQBryOIesgH3qOJ4nH+PyVNe4aeOrFHFdGqWyueG47ICBrI2eYEHq6hcdO58MnJfiALvAWY30F7zcFJzOyiFxQmkOeHpLiseoJO7OsVI/KOAYKP/muaPRCki3e+TTboWfv3wtKadQFpLtOpfEJQApb8SQIy8kDtnYls5LhWx1Lcz5FxbMBnEFs7H128ZXdNsZbkP1U2zKgkEPW0BE/GSORjc4kZZWq3IK+nAY+yu3vzYENn0vk1KnNXAbu4SfjRAJzUEcS0U1/YFuuYpiSDei3XYLdxO6iNTcHx6Z50xFE3OOx+n2nuvQ9F4thO5s+1kJ/rE8KxzzIdJwuJnoMXCU+O+DvQ8OPKyoF9M4W+oKPzad5MGnmxAmsgKvvqon3tBoHmXadjpgfcnIN30JiiL+WDpVpIn7nSfkcxg4UDce3t6RnjoapxjAlULq3JJ8wpQGYDhlj5h95+MsbFBV2dYPf8WMMNrAsqSfOlxfkTD4IbZheAZ0uG25vE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(5660300002)(52536014)(7416002)(6636002)(4326008)(66946007)(76116006)(66556008)(107886003)(55016003)(64756008)(66446008)(66476007)(316002)(2906002)(10290500003)(66899021)(478600001)(54906003)(110136005)(8676002)(8936002)(41300700001)(8990500004)(7696005)(71200400001)(86362001)(9686003)(6506007)(26005)(83380400001)(186003)(38100700002)(33656002)(82960400001)(122000001)(82950400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JWfwDhzSi4+MbSG7nla4nZZ+R2FHxt2oLd3pmECYgPDZEKGp5OJYCIwj4wtx?=
 =?us-ascii?Q?iiJ5fhhOjQZJ7rmQKmTqFSMwGeOMBcni4vSouQClI7M4GtaWKP5eQJdZQY3z?=
 =?us-ascii?Q?9LJGTW0zPYuZZYWx+8kxDI7wAYKCW5cwvLLrEOut6YbHcG7w1Twqa1hRHDxt?=
 =?us-ascii?Q?NqSZoqjhd6nlzhe/ufn5/pp2vmQNUjRLWhuGKdhhkogEhY8Oju4au+m8hZs1?=
 =?us-ascii?Q?ErRZjtLsbz+sUmdLFKoBWqHeU71kZkBLNq/FMzgzfPfJTBlyg+aCmfqCiXZS?=
 =?us-ascii?Q?WfeGhTr+FUHBC4e0R0jLatM8xo+D7klTBXy6TCeimSHihDwe5X5EcEiL+hyF?=
 =?us-ascii?Q?QS0j2XIRi3J8EW3LLONcyfrGcEnxqexggoIMTIszK+qb8wPQaMaWJCOGcvZK?=
 =?us-ascii?Q?ce4YQRZ9tBnVnVvAT833B2Wtt2bVot7oKhAciwqr9guFVSNGZzIfI9z3D7a4?=
 =?us-ascii?Q?eN93i1G52p3HVHXp9meH/a0RghtMLk4gLJkf5nsAxsTTlZqTFgu6hCVKqd+I?=
 =?us-ascii?Q?+O9XbPt7hjTxWgOnCFKPtM1ki2oV/HnYG398W5yLcoOXPKB7FpCxH5mlMtH2?=
 =?us-ascii?Q?dgTmxE/rjerNUNRUGuSjr9kjhLg55mMz3ZDTRaRkVQlVZtQakBOdp6UsU/Kx?=
 =?us-ascii?Q?L2YjTPukJiDJmLNW081vxRLxqHWe2QIfl0r1T0DsE0PqmRSaH0OJM5elMJMh?=
 =?us-ascii?Q?+MPu7mYIPoZJV60GdyM05kvE5SFxdDMYjez8aioGwbkpuCWWMF4vLrqBxWo5?=
 =?us-ascii?Q?XObRULBrkMDdYZJT8QPeklPhDRm1xMq2tSYqEByIcy5e7HmXZrpDb/nO5SV4?=
 =?us-ascii?Q?k8UNh92Q9bmw/hgP62Tg8SNkcqB32APVVJAzyASt0D9Ar08HHldsvm9q0nAl?=
 =?us-ascii?Q?4PkpKlarHgawleEsyuhGxDVcjKx/nlJEFtEpfIveCw3N233m45+0+7vaINra?=
 =?us-ascii?Q?XXioN/N5dn+jxjZD3FgXCYz0s8dtNEIkPfQn/hfZJqSM+tQWyWpS97YBwWyO?=
 =?us-ascii?Q?Y61r7LU6Pdplf23hesPKyWWOLyp+78PjGErXJeHITqpHNG+t5af5CZgbFwf4?=
 =?us-ascii?Q?5ofJS8vRHJmZUaTJJgjHxGnm4qt25xOcC1Lj49Tx3oDB9Mt7fjSXQlxBJ+gP?=
 =?us-ascii?Q?QZ7wvGbLkT8i9F/mFHqfv7so3QG06NQh77SHPWglIfXbIYcjEG9C4tZxsM0N?=
 =?us-ascii?Q?muNnpLqxqbJbbXmNgmSqSwxaanPt7TgCnqTBgM8Ik7HbQrIw3D+DojdbXsBW?=
 =?us-ascii?Q?BFi/er6zGyvyVqa9iBz8KCwNHTOVXRToJNLtwm0TH/ea9ost+J+Isz5/fFuO?=
 =?us-ascii?Q?CAwOj/RXvFr9ZxBxRnZ250z6mslsEFCW9y1EHruFbjgZliDwJkNoEN0XdqcW?=
 =?us-ascii?Q?Nd5EdiSCyoBS7H1QUTqoABvfimZ35yh/b0lbR3QiuOufHvqkPX2EVsZbL4E+?=
 =?us-ascii?Q?byBOYykANk7OEXa8I1y3MEOKvoBnMO4zd6UCCVWVI+MGFw82cP8bR+tJzQTa?=
 =?us-ascii?Q?zwtkLcNUT3kCs9I9N4xMck1KM+sXVyYDJQtLwNYP9R8sQZqIa+VFsmztodI5?=
 =?us-ascii?Q?2VRCa9NMgogJL6QbVVjHT4ajESwO/08ZOy/mq1De?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eab0af7-35f0-4f53-ce85-08db8f935017
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 17:51:46.9256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vln4EQe0mxfAqShOirFDRhHham7L/lNDNTLJqoxrrBXmqkZJrLBgZjtFpoEzGID0BfdCRbcjC7PtSZ92Li/Z+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to man=
a ib
> driver.
>=20
> On Fri, Jul 28, 2023 at 05:07:49PM +0000, Wei Hu wrote:
> > Add EQ interrupt support for mana ib driver. Allocate EQs per ucontext
> > to receive interrupt. Attach EQ when CQ is created. Call CQ interrupt
> > handler when completion interrupt happens. EQs are destroyed when
> > ucontext is deallocated.
>=20
> It seems strange that interrupts would be somehow linked to a ucontext?
> interrupts are highly limited, you can DOS the entire system if someone a=
buses
> this.
>=20
> Generally I expect a properly functioning driver to use one interrupt per=
 CPU core.

Yes, MANA uses one interrupt per CPU. One interrupt is shared among multipl=
e
EQs.

>=20
> You should tie the CQ to a shared EQ belong to the core that the CQ wants=
 to have
> affinity to.

The reason for using a separate EQ for a ucontext, is for preventing DOS. I=
f we use
a shared EQ, a single ucontext can storm this shared EQ affecting other use=
rs.

If one ucontext decides to abuse its own EQ, the hardware won't be able gen=
erate
enough IRQs to storm the whole system.

Long
