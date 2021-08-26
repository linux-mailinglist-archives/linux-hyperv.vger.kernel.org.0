Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4850A3F8F94
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Aug 2021 22:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhHZUVs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Aug 2021 16:21:48 -0400
Received: from mail-centralus02namln2014.outbound.protection.outlook.com ([40.93.8.14]:7871
        "EHLO outbound.mail.eo.outlook.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229916AbhHZUVs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Aug 2021 16:21:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl/AqBc1dAaZUgulAsdtk8h0S0bCT1I9lQtE2Lzxk7saOjtpSjA/cYKOgSr41xbulcbej+uikLzfMAyQBSVzybi3AkgvAcIIT7jYQsUM3gqaMimbzVrB0QVX87WYV3kCF5rreAg0wemRPunYFw5a2p/KxYAtQolFuy4zriWkbI/nFTVAhwy43B5/4HBxXqUNmBWqzse6aYud7+Fj1SHvrFFniNK7dOdPQCClbvrb4/1anYGw7Su4zIQ6FCDh8k7RdkvnPECuY1JD5/NQGDPy1Ma/fZd/kW9bWdwDH19W7LNqRyvJ5Obm4sa7TvThc4ndgXkKhPMxbcxru6otfumxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MThN5XRox+FPo4+j63sTcQDlp4IQfVpl0Sox+gzJQQs=;
 b=YHVVhsgVCXvW5luqHF/UH1JqGOWHccsK23T3y3j6olSkgPdiuo2xtkQXs/K06pL/wS/4F88EYhG5k87jac+ichoZTTkI+hhBvDRzM833FwKxysYMylAa3GME92Tdjy6czt8X1j1diL2RPp9/CGrk57M6qMMf6/QDSEF6XTZMvyYSCReJCL4zs6vsci6JfUEcmPsxkGZBZe5P5eEc6IaYv2zvTnUf2qnQYobEkF8bpkw10tJ1ujpKvFdv+a44nL2WO/jzvzqnoJrlcjGaZxa18XGpW5gmKIafJ8s8ignkm47cIIxtzkLPxmCcKd+LOMCXdL6/zLN//garY2iH7slPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MThN5XRox+FPo4+j63sTcQDlp4IQfVpl0Sox+gzJQQs=;
 b=ZKgQf7MwGOcYLWqHXUPjoWaxqZNf6o+sIGPhkWy6XVjYxWUlYwgNwgarVbwoUt4a7szsmjQGbOz1QiKmrDb+EGtHS0J4opy7KbANbXUWIXutBkzuS7lUiQPTZVWtC8oKBHQnUTPXYF4ESYXTqLU47Jp1dNNkNwkFSk4FJwBn+xA=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by SJ0PR21MB1918.namprd21.prod.outlook.com (2603:10b6:a03:2a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.2; Thu, 26 Aug
 2021 20:20:52 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d563:3f1d:58eb:e06]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d563:3f1d:58eb:e06%5]) with mapi id 15.20.4478.010; Thu, 26 Aug 2021
 20:20:52 +0000
From:   Long Li <longli@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
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
Thread-Index: AQHXmLiDgHJZXiucJEOu37Y9ArQK+auCfYUAgABrnzCAAa9ggIAAE6eAgAFXVgCAAC+1gIAABrVAgAACv4CAAAFDIA==
Date:   Thu, 26 Aug 2021 20:20:52 +0000
Message-ID: <BY5PR21MB15068C4370B39A1A376F79ACCEC79@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1629789620-11049-1-git-send-email-longli@linuxonhyperv.com>
 <20210824110208.xd57oqm5rii4rr4n@liuwe-devbox-debian-v2>
 <BY5PR21MB1506270100DAE3BAFCA001E9CEC59@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15935D5B518ECA1361F2EB1BD7C69@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506B6865DA2DA9948CEA8ADCEC69@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB1593E4B1051F96DB6E715C0CD7C79@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210826194113.yihk7ete4n4ej4gz@liuwe-devbox-debian-v2>
 <BY5PR21MB1506A389A26964A8C7768D31CEC79@BY5PR21MB1506.namprd21.prod.outlook.com>
 <20210826201503.ycckbcpu3f6flbb6@liuwe-devbox-debian-v2>
In-Reply-To: <20210826201503.ycckbcpu3f6flbb6@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4bac42b3-2651-4991-903a-7430f4c7a82c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-26T20:19:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3a81eaf-e1e7-4cef-eb9f-08d968cf00a3
x-ms-traffictypediagnostic: SJ0PR21MB1918:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR21MB19187272A5916938F6A5F1EDCEC79@SJ0PR21MB1918.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wrAE61Gc2oWkFOdU+zp5DoIPBDfqn5FqwA83gpHaJwLMdUD1Qmpm8DJdVVi/3gJxzYaJxKRf3RapF/4eiBn9hI+yUn/jdlMDgDp+4AEYM4Vmewcbv+nLARxLu4vJk0LH28io/BLT/OIZn+UEaBz6NSJ+XmCXknKBkvCIZ3dAD6jOjhwECH4pq//97uWmaelNAIhstg42qi/e/GafQ1v0h+hxkagzQwy6nFhgk9KlDMpAsitI5hoda0U4HJcb9SDSN4bRicR708+kYAOLdVXRpIbyOp02HS6SaQxSxhe6g7TOUmrLg/COXMEqRUauBpRXFzkLxDXscu6o/IHn+3hq221gcAYW0hr1nM4ZLOVAsmDjy3LBT66GiNwbTyRTIY2OXB3rd96LbfcS39Y1wQ0EGtx5s0EeXJix4OTnyMyKmuXAu1ukO7UZkvIaSdH4uEJWUf7bobK6HbaBKFA26pZJybq8BSJ//8SwrgihsSP7Y2YwUkmHl2vtDSQDBncnUTR46af/BMZ9MrLgMmqBdRvNJuvhF5p7rnuLpM08ONOwifz1ihn99up5QGAP+IxV16rNdvOxevphfo1lDUI4ABbf9/ozgFUsMDrySW0x5NUo3ZEkapFQWO0T9DBeltlWLbNteyR+Nze+c/FCZAUME+QX1eesHlPzVHHnhUEF7uQBz01DT0y/POS6eyU2kl3jqLXONEgt/If4y142MGU1wXEtQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(82950400001)(8676002)(6506007)(508600001)(316002)(186003)(8990500004)(5660300002)(76116006)(66946007)(8936002)(7696005)(71200400001)(6916009)(64756008)(82960400001)(66446008)(38070700005)(9686003)(54906003)(7416002)(66556008)(52536014)(38100700002)(4326008)(26005)(55016002)(83380400001)(10290500003)(86362001)(122000001)(33656002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?rPMH/E/gjCywM1yMXLlcyvWNXqoLUP9S6AGsgK291NpSTKTlVekMJukCNP?=
 =?iso-8859-2?Q?xypYDZLUkt2MADePKCVBRZqRCiLmHLMbuUqAf35dkRTnchwn6preIfzoOn?=
 =?iso-8859-2?Q?16K85qkRTUqJgTtQyiWqIBUrKJg9m9BJQi8S5lMVR5ZZg3sR312299HxbA?=
 =?iso-8859-2?Q?gljn125N+2zvlPA6gGpXvM/DTDfMIbSOma6QrMwb2FZjkg/BR4BzqBB8uf?=
 =?iso-8859-2?Q?ehFWLdQB0FwSPP6rt4RkUgLowrsGFzfQhr5a8FuUArn0/4KuEQXXNeIJ8O?=
 =?iso-8859-2?Q?tMvmDymkeK5+B3MeAUfDwkT7WlHxwYFl9VAqe4jASNqgA/8OhU+oMXUOnT?=
 =?iso-8859-2?Q?qOakD3zXjdrguVgHNO0/Awihxn1ycpRvdqYRv6sFP6lsGzkKhE6jmJnIV2?=
 =?iso-8859-2?Q?Zeo1Ju6GT5eqfhu9ZKG6WEA+C/9MpB5zpb2XpdwKBspWiwbhCUs3RKdcVz?=
 =?iso-8859-2?Q?9abBI3+Ez5kxIHc2fgQw/TWLgt0yxQ5foZxerC4Tel+TWKluwzUFqXFRJp?=
 =?iso-8859-2?Q?p6eKtTqfaqO3OsEQXAFk+5n29SciQy578uZJLSarvQRNXX7Qe1rEu+UnYm?=
 =?iso-8859-2?Q?hVZcssarNMky55X8It1CO57iySwFZEGCK4XFbVFagLVImbz6uNlHj9s2bZ?=
 =?iso-8859-2?Q?cTmUYX5Y3uoRbl7ukV+udDQ9SMqYEEFcebu5thK/tmH1c8vPfEVF4eAsZe?=
 =?iso-8859-2?Q?+Wqmv82Cvq0q9EVw1RUV24fErjWw9hj+9ZFHP+hiiJGYQ3YociXqkaEFAz?=
 =?iso-8859-2?Q?TizKG0WI0Am3aviokceB8TJt+0oAFADUqub/6+DMR8WdDyzh6cIVIFzvVF?=
 =?iso-8859-2?Q?zGYgSXP35fiwM91US/dyw0hWEuYVCNtdfsTpDFYzWRPMLzukbfV+6MQ3e0?=
 =?iso-8859-2?Q?VN9NplO1VI3P+4c0CfOdJNkZ5rztoAsDmi/8wtUMchICsUkZF9l0OCHc69?=
 =?iso-8859-2?Q?GHR/7jz5Xfzc18rxRRmxlVhondGcTYY80PhoFclsVmkIrOtohbUsSTmyio?=
 =?iso-8859-2?Q?QzJ77mnReGc8ry1+lM2LFTEXmV9tIky4soX/iEiRl2CG3i+P1xNLw0HeO8?=
 =?iso-8859-2?Q?HQQdBrORc3gPOVd0/T7eo+ic4JciSSnjuVEtSP4uaG9T4bfbVSFANBAOqb?=
 =?iso-8859-2?Q?S2W5m3SSTH24vAPQTbE9N35bA1PupWEGiil8GPudcBh1k8pXgrYkelrNZL?=
 =?iso-8859-2?Q?q7CIT/B9uRLT1ntMWZTNWY2WBkOFAKExZ5LOdytFfUPWIzF6LeS7lH0kQn?=
 =?iso-8859-2?Q?PGYvs2zEoc7G5mJtEV1t+sq+YBLtH2RqMTZg8kt/csskpB2EPGpUiAzgL/?=
 =?iso-8859-2?Q?RWtvK55ihK8qIi5CtnyyZsvC3fuTbsgHLJqkxtyUvusIVo4=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a81eaf-e1e7-4cef-eb9f-08d968cf00a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 20:20:52.7061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAinLzlAT2V5QII8XyfTl5befXczwVxaPCjo+iYzyRzS9g1unwMe6Gp5uoa7jTyKnVIRujz6GeeKIdXHVeSEfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1918
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [PATCH] PCI: hv: Fix a bug on removing child devices on the =
bus
>=20
> On Thu, Aug 26, 2021 at 08:09:19PM +0000, Long Li wrote:
> > > Subject: Re: [PATCH] PCI: hv: Fix a bug on removing child devices on
> > > the bus
> > >
> > > On Thu, Aug 26, 2021 at 04:50:28PM +0000, Michael Kelley wrote:
> > > > From: Long Li <longli@microsoft.com> Sent: Wednesday, August 25,
> > > > 2021
> > > > 1:25 PM
> > > >
> > > > > >
> > > > > > I thought list_for_each_entry_safe() is for use when list
> > > > > > manipulation is *not* protected by a lock and you want to
> > > > > > safely walk the list even if an entry gets removed.  If the
> > > > > > list is protected by a lock or not subject to contention (as
> > > > > > is the case here), then
> > > > > > list_for_each_entry() is the simpler implementation.  The
> > > > > > original implementation didn't need to use the _safe version
> > > > > > because of the spin
> > > lock.
> > > > > >
> > > > > > Or do I have it backwards?
> > > > > >
> > > > > > Michael
> > > > >
> > > > > I think we need list_for_each_entry_safe() because we delete the
> > > > > list
> > > elements while going through them:
> > > > >
> > > > > Here is the comment on list_for_each_entry_safe():
> > > > > /**
> > > > >  * Loop through the list, keeping a backup pointer to the element=
.
> > > > > This
> > > > >  * macro allows for the deletion of a list element while looping
> > > > > through the
> > > > >  * list.
> > > > >  *
> > > > >  * See list_for_each_entry for more details.
> > > > >  */
> > > > >
> > > >
> > > > Got it.  Thanks (and to Rob Herring).   I read that comment but
> > > > with the wrong assumptions and didn't understand it correctly.
> > > >
> > > > Interestingly, pci-hyperv.c has another case of looping through
> > > > this list and removing items where the _safe version is not used.
> > > > See pci_devices_present_work() where the missing children are
> > > > moved to a list on the stack.
> > >
> > > That can be converted too, I think.
> > >
> > > The original code is not wrong per-se. It is just not as concise as
> > > using list_for_each_entry_safe.
> > >
> > > Wei.
> >
> > I assume we are talking about the following code in
> pci_devices_present_work():
> >
> >                 list_for_each_entry(hpdev, &hbus->children, list_entry)=
 {
> >                         if (hpdev->reported_missing) {
> >                                 found =3D true;
> >                                 put_pcichild(hpdev);
> >                                 list_move_tail(&hpdev->list_entry, &rem=
oved);
> >                                 break;
> >                         }
> >                 }
> >
> > This code is correct as there is a "break" after a list entry is
> > removed from the list. So there is no need to use the _safe version.
> > This code can be converted to use the _safe version.
>=20
> After this block there is another block like
>=20
>   while (!list_empty(removed)) {
> 	...
>   	list_del(...)
>=20
>   }
>=20
> I assumed Michael was referring to that block. :-)
>=20
> Wei.

This block is also correct. We don't have a bug here but there is a better =
way to code it.

Long
