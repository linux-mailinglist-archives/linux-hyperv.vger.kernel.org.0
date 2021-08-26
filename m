Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DC03F8F82
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Aug 2021 22:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhHZUKK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Aug 2021 16:10:10 -0400
Received: from mail-centralus02namln2011.outbound.protection.outlook.com ([40.93.8.11]:15519
        "EHLO outbound.mail.eo.outlook.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243471AbhHZUKK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Aug 2021 16:10:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXzv+t17W8E/05iATjHnLcaKLTNnic1YH7tTNKiSL+AyKjotfzH8gquD+Zjh2rMtk+ieIbtmnXq+lpvi3XrOt2Hg0UiJD4w/i0REriWg7qixXh9us+tz8lzL8fnvfY+YDWvCUnU6eaFu26ra3Y7CriHFjMogbfknrL8To6LyJORTRC5SAu+2x88wluVaIn4hVYCeLbilR8J3LwyV+sp8ViTmNBiC+wDeBoHIp+womNOox5HB3Vffz7H3Dtu8yo6TwQDFcNljV0e29O5qWnop6RlccuajvnZtXhByd+s0gkUy6w0B+d694P21pJBSXdoRiiKSPj/J6IBCMpeoYM+dqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=497NcDEiWsvwK6R1hQ72plDJzMkdnTWrl2blnEPllWg=;
 b=dVtOetYpxE2cipy6hBuhHNdYVpU5rolUMKZZC0jWAcfqW6TTybeLn/vkzrVdeDAy0ntsj2aXUvCs2rO1JF4JbTbVZ/63x2Lp3EHD4nnyZtiBcRB7YO8CH+rIwQY23PWJnmgIeTb5qB2Eut66MaNfxsODHPWkvNLIMa2if4lRcnXXSvJSl8u64N4cMINnMH1NvNn4Cl9FiAPFFYtvh1F3mViRxnv8sXBzN9kittwFhAQDXPax4i3qopoYj1ekSU9n3jY+4FLYtdGotI0t6agxFfh3qfqfU/t0aAT95cAL/NI3sxpmceLuNh3jaZKpk/z3j6EqFLA393B/n2TRSj7ZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=497NcDEiWsvwK6R1hQ72plDJzMkdnTWrl2blnEPllWg=;
 b=M4svnX0YpIzH7Ol7x9ni+C00diXDRjEh5MufArtRqSE97WhTrSTWkI8OptDz9zg7kozivfRMmarLk8jIbp/rWIZ6JXDfok1frk0pFw5Ay5Pbisv9K7P8gbap/DmZUkPea0vtbmqoLo9Df127vMcvNWSbxtdMrSKiOwmnTs3F5xU=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1335.namprd21.prod.outlook.com (2603:10b6:a03:115::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.5; Thu, 26 Aug
 2021 20:09:20 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d563:3f1d:58eb:e06]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d563:3f1d:58eb:e06%5]) with mapi id 15.20.4478.010; Thu, 26 Aug 2021
 20:09:20 +0000
From:   Long Li <longli@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Thread-Topic: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Thread-Index: AQHXmLiDgHJZXiucJEOu37Y9ArQK+auCfYUAgABrnzCAAa9ggIAAE6eAgAFXVgCAAC+1gIAABrVA
Date:   Thu, 26 Aug 2021 20:09:19 +0000
Message-ID: <BY5PR21MB1506A389A26964A8C7768D31CEC79@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1629789620-11049-1-git-send-email-longli@linuxonhyperv.com>
 <20210824110208.xd57oqm5rii4rr4n@liuwe-devbox-debian-v2>
 <BY5PR21MB1506270100DAE3BAFCA001E9CEC59@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15935D5B518ECA1361F2EB1BD7C69@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506B6865DA2DA9948CEA8ADCEC69@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB1593E4B1051F96DB6E715C0CD7C79@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210826194113.yihk7ete4n4ej4gz@liuwe-devbox-debian-v2>
In-Reply-To: <20210826194113.yihk7ete4n4ej4gz@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d04aa65b-894b-44aa-ba5a-31bb5decfc6e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-26T20:05:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 515bf222-0bd2-4719-50b8-08d968cd63c1
x-ms-traffictypediagnostic: BYAPR21MB1335:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB1335AD5E7C34EC87A185C304CEC79@BYAPR21MB1335.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tI09aeyCHx5+HFqxrjpmM9G2egzGdS5DgF0VjCCM8N7zTiHrUuY0f+M1L1+JPdQh66aBK3vous7ZIymsKZP2d1Yc3VX6rfUbAx23yJG6HrGCaJ1c/J0u9+uPh6v3qpf1UgUGr23iwup204E3cgKBEUWljfQRzzGwF9oWSnak90ZApn4LSkDRJNZkfXPnlwO0tIvqwFM4ODjwXMpNSqyKlBeLFn6wW4La6IlISROL3LCnWg35JK6lyCHxDbSv/dyXL5bkAtky7SpzIM0Y6FwypA1jLgbkKbB6cvgsjMIRcPQWaudjPKPqbpR1hR4InwJ0ShJwRiP4FGgei6DV8nfGWkV6YcZz7yQphEx1XFt4p7pzuy8monrHfAZmNNkfRf2odCx+aiH+iBfrHBjlSmckCP7lw5B9BSkK8g7lttLDoxbE4Y6M7DZXzO7PsmoCK7es1UqI7AKBJ5IlRPf63U7oHFY9vv3D+omShUeILj4LwEo74YqbReRY99J8HvBclzwG2ulrkd02euXTg/FZILeGJ5eNlktlO4/5Hn4m9ACNIx1zFubDlC/9VxlCKZma1Lj/dpRhu9sbZn3PPNqBM+OrmD1N8ZNz1Le/vUzqv8shRSwQrnX9R/gCIW7AXVpJbNPuAhWYKDaBU2EjeR5F9BMmwJ+PvArjE904WHHvLXikpBN4L8bJLVMubqdUc+qxl/PxGViPd6sW8vK/L+F3JHLo7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(71200400001)(64756008)(66946007)(6636002)(66446008)(110136005)(38100700002)(66476007)(66556008)(122000001)(38070700005)(76116006)(54906003)(82960400001)(8936002)(52536014)(186003)(8990500004)(10290500003)(6506007)(7416002)(82950400001)(316002)(26005)(7696005)(9686003)(4326008)(8676002)(86362001)(508600001)(33656002)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?bt1Uf5FzHG4nWUKNnQs/ZBsq388vORE2PhHnzSGV5ABczDZb6UOX7IbSq7?=
 =?iso-8859-2?Q?cCwdsdeEjDlF0F4WxbR84oaW+Ybqc5zYn64g44DrUFWVHOveNV2k28Jt9W?=
 =?iso-8859-2?Q?5LO6J9bkL/vHq5RqsVFkBDMJ+oWR1uUAk5BqJecrP7outNUczOOZbiphDY?=
 =?iso-8859-2?Q?ahQ3ZnAoBuiK6heNNF0MJt1MSlwkh2jPnCec96MXJxLRZaG3KkUCbMtSgV?=
 =?iso-8859-2?Q?AjlihxJ7iXP0w0qeRGCCR4DgYyGCQVRLAE6PAqwNEU/u9lYBqEBWABj51+?=
 =?iso-8859-2?Q?pzFuCFgV0nGUdZoaRWMGzRN05HvoAS1eUm3mxKi9yVyLJYecqC86JWMJb4?=
 =?iso-8859-2?Q?ilGB63emaG65jjY0JU1ozCgAuKysKoXHLu/V6rbMKZITbQa/+odwVvVB1w?=
 =?iso-8859-2?Q?F03pKUo15qwijtGai/tLHIpJUGRQvIa4n97Gkcp0XT1Sg1Tk2CifzEUF4t?=
 =?iso-8859-2?Q?QNjgHUHMtjOiaGYZ2HeMffntGqxcvLcazYbMu+psVa5AEOp1k21e6ud7Gz?=
 =?iso-8859-2?Q?A9GKu39AWm0z9FSM+yc2uzYLnYPniZTPw4sW/KByct/nbqsFvebvl+lPsi?=
 =?iso-8859-2?Q?LjDL428s7A0nrZgWkeEWYqc/P+8rQRe68QSDf2z8iRHwgM6RmxjUMuSrAO?=
 =?iso-8859-2?Q?2+1DSeDhF7CoSuAXh+npO/pu1yO7C+kddS/klSpgklRS5Qjo5RPZrngux5?=
 =?iso-8859-2?Q?hkUQ9ZQ/Twjz6Q5C1+MZ+oPA0kBT+LAaczwVcf/KZxJb8PeJcRb0k8lIZq?=
 =?iso-8859-2?Q?xmchD0h/hrHfCqswuxImilsDpm5iLJ5DfS+27+w9d8KwOiYrxPswMYen3o?=
 =?iso-8859-2?Q?lByZbDBc7WITdd4dCI4h8HFR9OT0CuVC4e0Ik5JediQNB9YYV1RnIuFnE7?=
 =?iso-8859-2?Q?W0Zo4aUAjxFPakGJCiJWBGDbi4koZF2hD7cotiAOWudk6hCEkxofLEGf9r?=
 =?iso-8859-2?Q?nOtSgvUAUQ7So6v05w4SDFVn8Sm+8sfxLm/U/egdcBdjTzMO9Zrt98ZsmN?=
 =?iso-8859-2?Q?uetGNPNhvQXFJal9ekmbvIhLoRw5EoGBjqo69gqIrbLgnmiFwWFAItJtsI?=
 =?iso-8859-2?Q?PkyQAkJTTbrvycjeE/VqOAtXnZqV+aYP+xLc8Y5l5sk5u4ZILQBjJyQ6tb?=
 =?iso-8859-2?Q?r1Sy+pt6JYp/XSuEnv51v5an7haT19jNnlJF9ez/DCGVWbx+3OCU8hrurh?=
 =?iso-8859-2?Q?USjSsF6JQabiaF5TmDNNl5BcOwe9aGw5XagEDyslvVLF/YrMdRu9kT7FAd?=
 =?iso-8859-2?Q?h0lqL6QENU6cdWW2uvKacrHjAJeacRlbnXfBtCtZHQUuY00F2tTJoi48Dx?=
 =?iso-8859-2?Q?cLgZtKT2yyV7wEtEpxCLBnQAdMEOpbZ7O24EOWf7wUcWehc=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515bf222-0bd2-4719-50b8-08d968cd63c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 20:09:19.9320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyEpl4i8Bp3EmISmqlFZS/q/XiBlcIfqI3NO/yR76z6AieimH9ebrQysvZ4+w3nsKbl4lREsObEv16OTeYmRUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1335
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [PATCH] PCI: hv: Fix a bug on removing child devices on the =
bus
>=20
> On Thu, Aug 26, 2021 at 04:50:28PM +0000, Michael Kelley wrote:
> > From: Long Li <longli@microsoft.com> Sent: Wednesday, August 25, 2021
> > 1:25 PM
> >
> > > >
> > > > I thought list_for_each_entry_safe() is for use when list
> > > > manipulation is *not* protected by a lock and you want to safely
> > > > walk the list even if an entry gets removed.  If the list is
> > > > protected by a lock or not subject to contention (as is the case
> > > > here), then
> > > > list_for_each_entry() is the simpler implementation.  The original
> > > > implementation didn't need to use the _safe version because of the =
spin
> lock.
> > > >
> > > > Or do I have it backwards?
> > > >
> > > > Michael
> > >
> > > I think we need list_for_each_entry_safe() because we delete the list
> elements while going through them:
> > >
> > > Here is the comment on list_for_each_entry_safe():
> > > /**
> > >  * Loop through the list, keeping a backup pointer to the element.
> > > This
> > >  * macro allows for the deletion of a list element while looping
> > > through the
> > >  * list.
> > >  *
> > >  * See list_for_each_entry for more details.
> > >  */
> > >
> >
> > Got it.  Thanks (and to Rob Herring).   I read that comment but
> > with the wrong assumptions and didn't understand it correctly.
> >
> > Interestingly, pci-hyperv.c has another case of looping through this
> > list and removing items where the _safe version is not used.
> > See pci_devices_present_work() where the missing children are moved to
> > a list on the stack.
>=20
> That can be converted too, I think.
>=20
> The original code is not wrong per-se. It is just not as concise as using
> list_for_each_entry_safe.
>=20
> Wei.

I assume we are talking about the following code in pci_devices_present_wor=
k():

                list_for_each_entry(hpdev, &hbus->children, list_entry) {
                        if (hpdev->reported_missing) {
                                found =3D true;
                                put_pcichild(hpdev);
                                list_move_tail(&hpdev->list_entry, &removed=
);
                                break;
                        }
                }

This code is correct as there is a "break" after a list entry is removed fr=
om the list. So there is no need to use the _safe version. This code can be=
 converted to use the _safe version.
