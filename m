Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970AF3C27B3
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 18:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGIQpA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 12:45:00 -0400
Received: from mail-dm6nam11on2106.outbound.protection.outlook.com ([40.107.223.106]:25568
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbhGIQpA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 12:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTy8wIAhn1xDOeQEm/zm1l9uMN37u196oAKRT2A9S8vN7745qKPKK8xXmwfkkw5mzFxPpF9cWjfoDIWlR6WX7L0Kwh9Edv1O7kHoFpy8oQvnYYTk9/VCuw60ZjMuem4cXSE9GzLf89oUYZVhAwSI4JbTdILAdQd77GgyYlPcRLNttRu04/iUEi7UzxM1dNzvT+CDdOHOZS2zfO9L7hyERhO1jX+X3BZrHIwoFJEzfnAbWjDk09ejMuWhCgRDHHp9BCP3y+clHV7JSCISwosqHtmCvLcBm/Q+MYEoKmRJMZYzllLC+aYAdOtw5FRS21THiRvSP3Ivc8vJmJyZRXUJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVnDT0r3pUxCxQXeXJaQDgUfiK1gygZN1kEZZikg0F4=;
 b=ibUieBn6btYGnzCLgOt+mWXphALTrf6Y9T6UPIBcekvVtnVCYYqkqGyB5sLPa50Fp0xwQCsfd+rhCeZJBONkqI601yCQQpjFFsbcGjR36+s83Pve6q4B9ufkq4upbCt/mEohRiCWFR1dK6l56ROXIzF0Ui3pgep/jf9PA9TE0b/hQ2zVpBwNsXeRsV6+FJ/Avgc4NAG5sEzo8L+F/g1Mvpaamx0ooOufV05vNvqBX5ylenx2CJdH6/qK7q3ZX52Qyn69nw2aG6xCFB6AOZNjh0USJnGb76+tZLNydRyKf5kIu6vLJqJazQKskG/Wt/pPYvWsaSJ/Sfc7+/cwprH/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVnDT0r3pUxCxQXeXJaQDgUfiK1gygZN1kEZZikg0F4=;
 b=UGKZhlrEsa31tlQmM2mv6v1onfA1gXIZz5Ty86oHzhSPSS8YgZUplxomtQhBKngPxLCOxpTi1u73F4XNr6ZvioL43P60jklMnyWo+69hWHCkwBDjcjAEZTK0NT17nF9EhqNq8pp/sSR1RTdpr1JLDSAn7PnVsfABG/ef0Bus26g=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB0510.namprd21.prod.outlook.com (2603:10b6:300:df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.0; Fri, 9 Jul
 2021 16:42:13 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::f8cc:2c20:d821:355c]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::f8cc:2c20:d821:355c%4]) with mapi id 15.20.4331.012; Fri, 9 Jul 2021
 16:42:13 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [EXTERNAL] Re: [PATCH 1/1] PCI: hv: Support for create interrupt
 v3
Thread-Topic: [EXTERNAL] Re: [PATCH 1/1] PCI: hv: Support for create interrupt
 v3
Thread-Index: Add0TIVdcQX5pMV/TWWUfz5smDdQ7AAYBcoAAAzvoMA=
Date:   Fri, 9 Jul 2021 16:42:13 +0000
Message-ID: <MW4PR21MB200200F17E1D0E4AEEA87D0DC0189@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <MW4PR21MB20025B945D77BBFDF61C6DA8C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
 <20210709102434.c4hj4iehumf7qbj7@liuwe-devbox-debian-v2>
In-Reply-To: <20210709102434.c4hj4iehumf7qbj7@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2a6a17e-4ab9-46b7-218b-08d942f8814b
x-ms-traffictypediagnostic: MWHPR21MB0510:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0510E94A4CD167A20923C31DC0189@MWHPR21MB0510.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YjRtFPW92xV16XbwNcOlw5yFIWB5bWi2SlYcDwydb7RcMCW+Xwga1Pu2p3Mm/mXVzHNkxRBEi6cKLTmWLMfMBzO6P5MAwsMntkD8VXEoaZiax99GTedOTPeK5AD/u6mjyth006iJN4VyZfPvMEh8NKsXyUiND9o+1EG7ULyMeNZsNrbW7XR0rL9XccnNuW+r+el3c77GezWuCD1Ckz2hU71HnSt/t5WS3wNEYc4rcqfRSxjOxiUJ2GUsxh+GC4sVEqPAMG+qKi0oOlv+MSeB8Pn92J5dHNgpth4Gc+new13Ou64zbK703l79xbu0TMmkkG+EwAjWZQAD3DV6QglN2gK79hVRFT7Z63V3LOz0+JtwhyHTLqOGZrr2ZccJX5//IKRuCP5bX9yqeeHEopElhVMG1y9NUGRZWDaX8k2Y4HWOvfJXlfDgN2/WkoROeLRkEkmVXm/XijfY1KZ+Hhdk99cCKqJbHVBKzcONx9BSsiYoWl/XpdmU24ghMmGZAwCUQfiWIsuScM3x9Rsl814IH2uM+aWwCqup4/O81+uqb4WoT4DERlp4Y3yj0oKUJoN39z/ImiQoNd75Tyy3646Bs7SPW16B0TngMZuh0O1c1UDs9JilEuJ1KFlNk8ZVI9phrPuzr5kH2FkFngHgF4eH1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8990500004)(83380400001)(86362001)(122000001)(6916009)(82950400001)(64756008)(66476007)(66556008)(6506007)(186003)(66946007)(9686003)(82960400001)(8676002)(33656002)(38100700002)(8936002)(5660300002)(52536014)(10290500003)(2906002)(7696005)(66446008)(4326008)(71200400001)(478600001)(55016002)(316002)(76116006)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+G9mdU9YIDdcYMryNwsENnm7x6O73a3n4JqmiTz4T8ZiRCg+JCTxbNL0JQV+?=
 =?us-ascii?Q?LeJkie1tcNf7/cWmQY5DstcAlRQmJsC8YiZP4DxcfyVtuttnSGxWZQQ4GroR?=
 =?us-ascii?Q?FEecUHt9ShAdxgo0MOmOrUweQ8SFPdkocb7dx1E3nl3CiAq4rp0i/fXpt61C?=
 =?us-ascii?Q?WNF5y+BRLNFea9qXnN+OJ7z4BFoEXySTV0/fTXoT4CZOH8VHLD5durMXIRkB?=
 =?us-ascii?Q?PI0myeXxEc8zLI1QPtpA3SEol0i87cd8YdlUOIRMTYqQ9OItiiAK7o5prhz0?=
 =?us-ascii?Q?5Vb7dzP17iXFxxMSeJS9gMqebY0bVQRaouoGC9THTE3kZdTVWF+8oaY1s0gL?=
 =?us-ascii?Q?BRTgQHq7eSBD0T+u9VacPM30m7hwGf+XOvvI0dQFWiwWPsTWg7h8GJAM72SS?=
 =?us-ascii?Q?CuUYP79gwW1ndJF2km6f5qYsiY5mCFjal44c1XXVkuBh3UIqgW5fAdcNffHO?=
 =?us-ascii?Q?8c65YzlmSwqTwSA1ybGtP6zfbcVtokI7bWyfrtKVlaZc5/981ZOQ9lOebvSU?=
 =?us-ascii?Q?PJuersbyfOsWexnToLeSzUlrh9jSMvH11gvDk9XpEIHzOrzA9JZHViETLex+?=
 =?us-ascii?Q?UQl0in0/QAc9u0n2GOO3uvOcH60CB2wgg11XZ/2jydnQa1g0doyVBXSnEu9E?=
 =?us-ascii?Q?ZBTNK8T3qlM+UwBtnb9c7bTDylpnI8sMzc9igIxAyVADQVwoYa59IMHwYBQj?=
 =?us-ascii?Q?X/9Naf8FOY7L/c7+rTdaghsgC2njSmEsbXTjO8BwN3ktXWd1Fh3Q9mt4Dh8M?=
 =?us-ascii?Q?brAImkJNSaoDPgXjsCtZ1Jn2FYfKGknYSJdPx/TQ3eMUZIb7csQxHgbEKFHc?=
 =?us-ascii?Q?YFVoAu8kK1r9IdNQDFvMLF7ezBA75kX7c00lPoPk7YdRj6GFhfAJo+vUEI7J?=
 =?us-ascii?Q?BPfJ4OVmoK8U/rzDu8G9QYiQ+FoA9H0I7Q+v2q6SyYmmbofbSJxrUcuke7oD?=
 =?us-ascii?Q?dAgIOtr2V9c0W+TfZvMSDpR4A78/r5BAOtD/5g8HLLaORxHT6pRzMbk/WYXp?=
 =?us-ascii?Q?/o9FoX3dGRtQdv5/0uy3lVgg53t5K78AMuB1zsSG/+dr/4YaADPBmKNYZCVg?=
 =?us-ascii?Q?l4OL5gr/yGQx29FclO+recQN/oa0RU7swnRUrGMxCjoN2MS4BzGznCbHgOUn?=
 =?us-ascii?Q?aE0c+ED+delEJtBO08sLnh8K71xxEg5h9oTr1JiLVTwlmlm0k6WpzA1Ej+Ek?=
 =?us-ascii?Q?BYBKD9g1Qvo8Y1bc4JBJdY0hzWttqHt4tOvO98EEJqaE6n1Qq22H6Ul6PsIt?=
 =?us-ascii?Q?uixLtzHYksrJq3Bbe8w5Aqg8qZU6aMojZYyFYZR9xbPX9q/ltzeLCtQBHUnO?=
 =?us-ascii?Q?0LZuE4J0F3u0dAcYtyL3yxRWv+WkhwMR8pIHrSrfHhJpqIRKsdYwuSccqktq?=
 =?us-ascii?Q?NVra/WbwVdq+2AeurICDSGcIDNkp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a6a17e-4ab9-46b7-218b-08d942f8814b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 16:42:13.6649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: golI9Z5X0mYpbMJOZ8dokA5Syu8qyZqwvTK3XSqL66goMhj/wh41rsqEenN+KHJnAUdARUPzt69P9Rk3rLDUb8IWngfs+fHievQRkcDOtHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0510
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > +/*
> > + * struct hv_msi_desc3 - 1.3 version of hv_msi_desc
> > + *	Everything is the same as in 'hv_msi_desc2' except that the size
> > + *	of the 'vector_count' field is larger to support bigger vector
> > + *	values. For ex: LPI vectors on ARM.
> > + */
> > +struct hv_msi_desc3 {
> > +	u32	vector;
> > +	u8	delivery_mode;
> > +	u8	reserved;
> > +	u16	vector_count;
> > +	u16	processor_count;
> > +	u16	processor_array[32];
> > +} __packed;
> > +
> >  /**
> >   * struct tran_int_desc
> >   * @reserved:		unused, padding
> > @@ -383,6 +402,12 @@ struct pci_create_interrupt2 {
> >  	struct hv_msi_desc2 int_desc;
> >  } __packed;
> >
> > +struct pci_create_interrupt3 {
> > +	struct pci_message message_type;
> > +	union win_slot_encoding wslot;
> > +	struct hv_msi_desc3 int_desc;
> > +} __packed;
> > +
> >  struct pci_delete_interrupt {
> >  	struct pci_message message_type;
> >  	union win_slot_encoding wslot;
> > @@ -1334,26 +1359,55 @@ static u32 hv_compose_msi_req_v1(
> >  	return sizeof(*int_pkt);
> >  }
> >
> > +static void hv_compose_msi_req_get_cpu(struct cpumask *affinity, int *=
cpu,
> > +				       u16 *count)
>=20
> Isn't count redundant here? I don't see how this can be used safely for
> passing back more than 1 cpu, since if cpu is pointing to an array, its
> size is not specified.
>=20
> Wei.

Yes, it is at the moment. But, the function can be extended in the future t=
o take
a size as well. But, it will always be 1 and I preferred keeping that infor=
mation
with the implementation. If you have preference, I can hard code that in th=
e
caller. It seems fine for me either ways.

- Sunil
