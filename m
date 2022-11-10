Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E495B624C26
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Nov 2022 21:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiKJUuB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Nov 2022 15:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKJUuA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Nov 2022 15:50:00 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11020021.outbound.protection.outlook.com [40.93.198.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030EB45A35;
        Thu, 10 Nov 2022 12:49:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7g60CCJv/NeBZy4ln8nXPZDAeSJZz/lGLD2tkmQ24cmM+yCiQq51Nc3ZVqM6T+YOH4fO7l8uistnw6VCf7e76HZOntViTUwPNNNB4F8+2Zx7NAa9k/7xK6I5whvKPgX9GGsd6FwmO5YVVujpHJjPVqBsxD2c984PYaovxtbFPnevB2oS/SE1VtHNQO4RnDI2wx+/RHyPtchYbzcQK0sUztaN5wnsg3INoaep+7dEXTTdN+LIszyY+gNyWZbpEOrJPaf+L7S+GK9ZJvZAEmKBa14yNwTR4YUIUUUmiPY+8O2+LlXF0u9vj5PhMe3FELl4Ohu0Rj3HXGIl5AVvYUWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyqxfsYfMxcsSkgWhmLt/sw6Xk/lbRfvYswAKDTymPc=;
 b=g5cEcew+IktRr5hmv4o1aflMnx0l0CIF/EoI25rCAuQ5pgeCrdkcOd8vwbEqzIcDfYVqteZrmi7MtXUcy4wjlOq8HXR+ns55EPycOPdDoNNEmHzJKq+FcyhWhnqHBcfPij6mRwfK2+Oqz+nXOYB8tVTS80bMyXTUlxQ4bM76RURNg+sQvkV+WeMZDf7jzvm/9sjxeWcFD3aMYFjeo62/dyBY/60gmnWNWqTKmhPzP8OOhdSkgVZEVhjAUPxtsGLIH1oqzjgg8EoqqGIlEcJ+8+on3w1OIAWUrH2nRJxKemmlgHkKGufwbhAHE3Xufke2+XJYZRp44vFv0h0+hMPmzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyqxfsYfMxcsSkgWhmLt/sw6Xk/lbRfvYswAKDTymPc=;
 b=iB4zxprjR6nyHL+VeHdn4H1PTVG8m3Trkxpzj/eaOEYueTsCEvqcudB1fhZwXxNWR2JB0yh7pJjzPoQ45XMQGLjnL+GeqWqAIAyNLlH71nHdX4FtW+T9dsmyDSByo6y8i6ACsOpt7AxQhCQlaz+w3UKNnjs39ODAgPd8xEdhVf4=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MW4PR21MB2060.namprd21.prod.outlook.com (2603:10b6:303:11f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.2; Thu, 10 Nov
 2022 20:49:56 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5834.002; Thu, 10 Nov 2022
 20:49:56 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
        "quic_carlv@quicinc.com" <quic_carlv@quicinc.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Subject: RE: [PATCH v3] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Topic: [PATCH v3] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Index: AQHY8J0alQKzFek9kkuOCBwYhpuQEq4vaxEQgAk84PA=
Date:   Thu, 10 Nov 2022 20:49:56 +0000
Message-ID: <SA1PR21MB13352616E4DC28DD0D9372ADBF019@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221104222953.11356-1-decui@microsoft.com>
 <BYAPR21MB1688378A6403AC46FDF41B7CD73B9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688378A6403AC46FDF41B7CD73B9@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=35228208-0f21-4b36-b68f-17ffd3e36c8d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-04T23:35:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MW4PR21MB2060:EE_
x-ms-office365-filtering-correlation-id: 111840dd-b682-4452-848b-08dac35d204f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kaqU5hKh08AxIXSrWKTDeRnkWlzeMePo3SGMFrL5Mj710k6XECQyXuga02vgef575OX5rwLLziTi6Rh6Dnn3L5NZRHefD+WL3p23gaI+fD0C96/fQKXtxal4TbFWWuQGARqWvmFtolPudbFRVaVuSYCcB74sYd28t+Lgx6wf14+3oo42lLVZgXnBowHGhZu0q150KiGZnDicxR0u1yvzYNRTOnPKKtSAAUtt6ivpCvMptf15n4FW34XWJcX5zVypV/z75Fk9f51DebqjBfHfHFXBlw4XFMWQxtIWc3aF+1e4cj8NlXdAVYDeOekgQTuKOBbpvKXCKxTmibAdO85rcUKpKOkjE0LZnH/GETIQ0Rn1Rxa0vRJHvppkGUIHAxhhNCHP2hZTtwVI1ZenbL35bA5if8nT1GQDsM9VG+SLUiE+GqCx6CMPCtv8RSRHZ3/e6qu2gfRGu/12PuRGN87y8xyIYKW9rTY4KN1kgN9whriN5PdsKpO6oF6ztWTj7U2Kys3JdMnBgzZ98iCY8Sv3uIM9UE7a/kdt6jlrCv5CNblwlrcqq5VkvJKtcXuE5ojhkVukr3LoGk2kgAdRiXGJX3hg/u7g8RjXmc5pGWIJRYn9+7o+u9N1UPH0Dkg6J/Or9Jw08FxrI/VB8rT1udm2b3y9XQfkRLxwUsrAb8CMAZiXq/rB7dvnYPD9Yw8ROo1L52OqDRaUrPdH5ao8QiWp2nablMa2Sa5/j+5GMKpxpX+GFvHpgIn++F+qgCdprpdrIBfPIVoL39yL3KFwRCYMSCG/AIVjXEOPfmeBJhj7oBfN+rgtPPHna0FbMU5Ai1/tq6yi1NUBC7WEytbeYx06vQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199015)(921005)(186003)(86362001)(82950400001)(26005)(38070700005)(38100700002)(122000001)(6506007)(10290500003)(4744005)(82960400001)(83380400001)(8990500004)(7416002)(2906002)(52536014)(5660300002)(8676002)(8936002)(66476007)(55016003)(7696005)(478600001)(64756008)(66556008)(41300700001)(76116006)(6636002)(110136005)(9686003)(316002)(66446008)(71200400001)(66946007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4tnsrjM/XmLD6kUPhBr7p7ElGV1xGK0oRKiN8BR9oX/Wv+g3NCGxohiVxkch?=
 =?us-ascii?Q?LvXYlpBj1S9PrhmDw7BTRocE/IRcxYmYoKFHBDzc+TFYHW1skwODB5Kzdob5?=
 =?us-ascii?Q?b/HhcD8PcXMtWwJf7Ssbl77t4RBC5gM6DXuha8qO/B7hxiqki2SiyYUGqImS?=
 =?us-ascii?Q?dy4z3KTOCpR8uLgsjb6h8/+EzdIslimNZz7uIxe+45tEkeRbXFkCP3Owz0bm?=
 =?us-ascii?Q?UTzbE6imznnGhOLDlK/u+8KJsD1Yh24RfbFTr8OAXMdRcoRgq6aP3JT0kPv2?=
 =?us-ascii?Q?iZiRg+Nk3xgq0XGzF+JvWbCd9qz7zqD+4B5D0avJ1aS3b6UdfPz8oAkLL0rw?=
 =?us-ascii?Q?LNLsqYTkeIvGNcUuxyDLwF8NBZk+ZOdXfN0kO8PF5vQUrQNwKhfmJtF5tLlY?=
 =?us-ascii?Q?RuifDbq2axFMXK9uaHEoNighZPrwMuA4iRZUVhSSkAcc3uhVaGXbL7HIlpq9?=
 =?us-ascii?Q?wbFmFHrMFuFv5rtRInO4BIbj66/t+Jg+8042icCsOZ484E1B8OJl7H8CIknN?=
 =?us-ascii?Q?lv/HtkdQJP1vZAGrBHXWE3aIVTfF4VMSKObs/5JSVnz/Pah7cqXOaoNn15fe?=
 =?us-ascii?Q?m/X5N66a0w5ptlNsx6gsmjsFo13/pyMu5+Sesu7shre3nQYG365Ev+ErB1RS?=
 =?us-ascii?Q?EqNxxp8e6v9mWITIwkZXKbcxTvYHPWGorx2Xum2trcxKN6Yt0NoEP9NJ5LV0?=
 =?us-ascii?Q?ShrJRT/Kdz2dhWxGottQ1j71E6aC6j8y3YNuSbmC621su2AP/0TaRqNgZQtX?=
 =?us-ascii?Q?JBauCkTV+9DTxDoB+EZRl6UehDy9oIXD2mU0SVjv9zL2D6CnRSgkZLRX+VEs?=
 =?us-ascii?Q?WGaSGKqwA8P6BZ8avJyZrUM10mOxLwC9Z8qmAT7a/AUs094eO5MwQ6d+JCEI?=
 =?us-ascii?Q?Xu/rv0CieZiqOU7LEXaBc7TD6DJYUGhCwHIOC7vC6gYz8I9V86z3UimG8kyi?=
 =?us-ascii?Q?fvWU9YYGfuV4ZxzRqRda0quEUwVtlqlU4JhxRjljOknvOic7Ps7QOY6lBKBA?=
 =?us-ascii?Q?WNUJmFV/I8Rq87TNOkLY3UCxhCgjHzpaDw8DepZkuSTC2OihcOqQ2cCNWlm8?=
 =?us-ascii?Q?G6SG8+eJrgAiQbFAd4aKMuK18z378FBdvGDYn607EKUaH1TEUrRCGABXZWeq?=
 =?us-ascii?Q?tfLcc6Tn4zQQfaSfUMAR8yfPzwLPEu+jdaILJjA/iEdyW4YUrUid0Ciw8gWp?=
 =?us-ascii?Q?+qHVVVndjOxHv8JxzCmDaeDTXerNK4u9h2wIDKYAwzBMUsUZ/aJtoYCerRxm?=
 =?us-ascii?Q?CoVXzETM7mhHnzZNwZDydix2/Jjpmzx2g+nLniUKSExUd/UlPRcr4tQE0d2g?=
 =?us-ascii?Q?qp8qb5pzKsbEMzwfD6gvl35u0ztnefnFVn6ZOW5o8whxHpwP2HC45Gg6PEN7?=
 =?us-ascii?Q?VbcLszcLbIrXsCaaGrGslWPZ1mybsKL65sAlCvQcZaT25Tn+CgOaCHiMcQT5?=
 =?us-ascii?Q?PXjAZAKdlA9HDyZPw581mIArKYViEzFe11W31i8DMEzbswH/Nbo5eW4BCvu0?=
 =?us-ascii?Q?Jgns2WEQGgQ+2sluUSS6I6xKmyp7r5rjHmNdKRbtFGLsa0OIabXewi3gIiSv?=
 =?us-ascii?Q?pMChb0BivDxaYX5ssAn+RHdRaTFO0agWBdOK3BdE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111840dd-b682-4452-848b-08dac35d204f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 20:49:56.7647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LR3kiIba+h0ph3VzvqyQH3Y8xlfoojrFmhUwnQ2GhOrRGJG8HD5YPOZjnQW4GSfGWz/wuan6j5lAK7uYFifP1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2060
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Sent: Friday, November 4, 2022 4:38 PM
> > ...
> >   Bjorn, Lorenzo, it would be great to have your Ack. The patch needs t=
o go
> >   through the Hyper-V tree because it's rebased to another hv_pci patch
> >  (which only exists in the Hyper-V tree for now):
> >       e70af8d040d2 ("PCI: hv: Fix the definition of vector in
> >  hv_compose_msi_msg()")
> >
> >   BTW, Michael has some other hv_pci patches, which would also need go
> >  through the Hyper-V tree:
> >
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Hi Bjorn, Lorenzo, if you have no objection to the patch, I suggest Wei mer=
ge
it through the Hyper-V tree early next week.
