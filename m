Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699F7520851
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 May 2022 01:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiEIX1V (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 May 2022 19:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiEIX1T (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 May 2022 19:27:19 -0400
X-Greylist: delayed 92 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 16:23:23 PDT
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.57.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025BC16ABC6;
        Mon,  9 May 2022 16:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k08JeDkOkOnH9U/UePWP91J/M0KjZbi/WMIeKQ+eDzqHG7MvTHS3maX5H88+VW0VsL4jDUxdjmwf/daIKrl5aWkT/zYZK6MDw/IbBy9tgHFi7yn685vqzO9kwwGFEUC2t1stDPq6QNRiHXU1lkqoRBXrNjOUaFMWUAuKFVaL4Vso9GRcP54UHo+I0uoF4BZtfUjoJ9lcXB5dj7psKvaaspt4z+NYTUgx0RpNvS5OkV5gADXvn41zOkAhmfq9vZkNeswlufV/Jk4Wb6XHBPtdZnh+gZZr+tfA75MBvR9nCcAB9IOOB91xoRHxBSRkqbsHuoOjRFvFtCqx+seIBLbbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dW5FYl13ksAoS7FVuo5HKBtahE4vgEC8hforx0x41C0=;
 b=aNuDsADzd5gQtU0fDUUS2a91glEegNBefV5OcIDZEDdhI5IZn85rOL+nSsG+BKA8jJTgv+wK+3bXlFG140Uo/B13nS7V6kh+26FQOihVICSlnVqI+gNdgUqu3EWHYGOpLICQpP6g/lOOINeUfAkV9uAYWubMVm/p1pCiqHDAhxb37+S4iUskI83VFqOxKfSa/FeX+LX8JqFyFvjIKeDd87RtRltczf4ApL9/ukmpuzzbWaNN/IrZobCySrrE2VspOa5CqJtIpPGSKtCpR0x524RDlYOw3zADACmZEiJo+jwlzrt//YlnISTbX7hQ2CDLQntIgr5+/PvRlpeGA3+e+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW5FYl13ksAoS7FVuo5HKBtahE4vgEC8hforx0x41C0=;
 b=ECO1BqWM7wuwZjKbR3xUjLiBW9/FXG23iOfMk+3DqT8xgpjaLlzQEbfcWpHEiBXc63qSEs3cQhkzrKxW6lCqincqiszFEKHhjrbsr8iacLS5NczKgYme1q8R7p9wQsTs1d4pkkRWLpoLAIYvLOozYW2mXzLx/CWGw7uuzJ/gpoI=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by SN6PR2101MB1614.namprd21.prod.outlook.com (2603:10b6:805:54::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.4; Mon, 9 May
 2022 23:23:16 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::e418:c952:c12b:dcaf]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::e418:c952:c12b:dcaf%8]) with mapi id 15.20.5273.004; Mon, 9 May 2022
 23:23:16 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     Jake Oshins <jakeo@microsoft.com>,
        David Zhang <dazhan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] hyperv compose_msi_msg fixups
Thread-Topic: [PATCH 0/2] hyperv compose_msi_msg fixups
Thread-Index: AQHYY+6PQXwoWccaB065whM7URRYdq0XL0bg
Date:   Mon, 9 May 2022 23:23:16 +0000
Message-ID: <BYAPR21MB1270A640D62BBEFB1ECE1307BFC69@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
In-Reply-To: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cecc330b-4d56-4907-bad6-40951e069800;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-09T23:21:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b92f46b8-25b0-4a11-71da-08da3212e55a
x-ms-traffictypediagnostic: SN6PR2101MB1614:EE_
x-microsoft-antispam-prvs: <SN6PR2101MB16149AE232B95ED6310D5939BFC69@SN6PR2101MB1614.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wld0BWX+erGbveVkiCFF0d2e/eEultraUCg7oJdZMp/9rGCuVuyIYo3+6auUuqUbdsyGBjKJkxy7yw7XrQEthcYxwLi4LyNXdW/KGwVPpL9GTOL3f0ruCSREAbRHiI1fxjOinrA0PM7UNAZBaZz9kwOB9FktPdDsNoAz33VEj3M9SENQ08ZUEJJEP2dK++mZvkl+P/AeOnpsyq8ZvMqAYhzVVnAV5rDUloFHS3AXaiOzqcNLpqq6HvltDOAJHDdU+OnyzsvPIv+waaKV0wBUCA/nBXEcE0GnfBRlITvdShrNreYNmAsmZmTVx4BrQgUnn1C7NwMwBSUcKTlo14hM2URYiDjze7bvQD1LfXD5UuxisM5eFG0i/AWAYvoO+FM+KnYOsQLbVmF3jtoOFz3iSWQl9kMr0XmSv2s9jRV3HCgIARIAS0i6abo8tcsG6vp/oUXs7NjhmU312zXiZbrCTKxBnfgw3Z5ZdND42oSA7uL+Rzw+CaSudhU8eMbidHlIykhW6fF3CEGR0HAU3UrB6IZyK5IHyl3P8leshWZH0D2ZqIyQDUfMfvZZYqyUQqOEwmIdvt+uH+pEQQaG7a0/UYkXbY9D+8ZWVP9sXjfT/m119NAiIXeloRV29EvEFa5/smR5xkqpayo4FJQGO9oyoYikewqF+CUfi0ehKlsNX+1YS5ul5V1yGy5Hl1cwcVbXM9P1LqaSo+USJao3QjXci4/lIxe8Pq4gUqNuxP6jZC1NMUTdIQ3lDto2AL7SToud
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(122000001)(186003)(55016003)(7696005)(82960400001)(26005)(9686003)(82950400001)(86362001)(6506007)(66476007)(316002)(66556008)(8936002)(10290500003)(33656002)(8676002)(558084003)(110136005)(38070700005)(4326008)(38100700002)(64756008)(2906002)(5660300002)(71200400001)(54906003)(508600001)(8990500004)(52536014)(66446008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zxZN3Y+87H+AlOFmiK7FDDiRB0lwMEGehU6mkvF4kUIsu+KLIcnLeLERtFNV?=
 =?us-ascii?Q?NVYqN+6wfI20KLOo4yXZlPvYYXlvJGceiXIsjpTaI1UAlj0q10fAGXdiMi0S?=
 =?us-ascii?Q?jha02HrkrobxhJ3oun9lJY1lS+XCydSdNwf9aGraaSoJbpZ5OKLNF+c+ELC0?=
 =?us-ascii?Q?TtGBom/NIP4SDoj1mMH9rryTmU45uL78lB0OounVWXGXYc1wNNM/XZgDMuXP?=
 =?us-ascii?Q?c1eVh7RN2EzbtJW0OKdRi6EObgOi1GV3BT4BIN8I8Zo+rSm8tOiCweFGHWIN?=
 =?us-ascii?Q?mEl4ZquWwPSVDXCJBpCWItJ6qtvHMLudL/mOOPVVF4W3piIbpoqjJ/MbPGwM?=
 =?us-ascii?Q?bFM+sOzUVd20brkDTdTypuPsomAqS7hP1R6zq57QY3dvPv1emqU+2AjhCsJf?=
 =?us-ascii?Q?a7plNZRm3QR+Pr+9yOqlLXRVZ8meB/IJSPbRmCYPIUcL+fu+g4c1+6CkpGxI?=
 =?us-ascii?Q?bttSgg15ZOIUQ+EM0HlsyM3lBWkpFzkLwYKVEF9Cua+lrpmsiMzc8gNy3k6P?=
 =?us-ascii?Q?XiB+ee2t2XtQNSfdgima/AtixnjS4pbR6h925bdJA3jUxaN3Wjm73B9V6Cdt?=
 =?us-ascii?Q?tgL1QR3RV74I6+0tdidRjhh8etAFOFQxJtjKLviwazAGLAjqmEeylqH7KF8d?=
 =?us-ascii?Q?QuGFzgc1xop00uQHCmdepob167gqEUhPsUUUxLSR4ATaPa2RgzgLhAvSelRD?=
 =?us-ascii?Q?9hKAtMQ7e7xDyQRZ3gqjEGxkpmedVRFmJ+KJtw4L+UpnDcvkVvZw2ZyGFhie?=
 =?us-ascii?Q?7+STD4WMTGSr8/d1ztjnpnhMjChz5ULfYqurvFT/8n4IJp0A7UiD6Xx7J9FB?=
 =?us-ascii?Q?e4o5rjm75gqZZalwBFFImZm/2r2VtmqUgFLOaR8uVxiG8NDTqM8ddk1jqxfV?=
 =?us-ascii?Q?sYKBtxKjIIYmQ+oe1bx5HBW51e4kjTdOpbl74b4/2uP5KVHAvjx5n4aX3DVH?=
 =?us-ascii?Q?ICtfgpvOaE+FTa1NUeNZa5GQOq9m3Gatlaw8tVVLrAuKzJLvUEcAGZfVtE3t?=
 =?us-ascii?Q?1aPRWis891n1mn7xb2pEXCQOmOoBK6OxMvlE/fd73aPu9gUyfkgyocI4be1F?=
 =?us-ascii?Q?6uES9wJQUc8YoedBugeUebD73obqZXoVtY1cgSMxpzc2YImbMPrYz/bRcvbS?=
 =?us-ascii?Q?1osixWPb5n/gH+/djxYbZP/zk1+UxfmDJr9GdOK3RcPBHgJndWn7au2Lt2lT?=
 =?us-ascii?Q?R/e3OOKK6BQAUCpCih7aL0Rgm6oP2surcNYYn0umXdnqKWm1iVDrU8t/TNmE?=
 =?us-ascii?Q?dRCkSdog1MrJKiTP1NJyiLmqQAZdFlsqhpNNyY+VkZec9YsNRs7fgVl05jBf?=
 =?us-ascii?Q?4hKZ7CA1XxJCirbuQ2C3KWK2p47+QySB2Xi6/6RD+yoLnIovmmei6rb9dwD5?=
 =?us-ascii?Q?TgCaLkfIc8G90wB1SNOWoUszA78x7uKyjcFAx1VA+Ce19T7mS10QQ6kyR74H?=
 =?us-ascii?Q?HDAp0+LH8bNf77HSIWZuKK1kYdUi/C78mfumAZy2is47cOW8cjgEgjK4lHDu?=
 =?us-ascii?Q?K8FcjU4BMxMmn3KxyBKgzTrm4obA+sQEsgb0KKUxUp8pE4GyH1jSxZLiLfWc?=
 =?us-ascii?Q?gA2BsUhLDpz2DCRdZTTsh5ewH9p+9nyCoJ5+QdAObJHJjTt2ai3BrzfWPkmD?=
 =?us-ascii?Q?O0IZvWCSSemIYRTlxdOUH27t7py8QpUaELBwxuJUwkMlfWpcE5zFxw0vk/RD?=
 =?us-ascii?Q?LLF5TWrnCuHo3cxeW4AM0/upRA3wm5POTtmOY3H3qsmactkumT22lgZwSEOL?=
 =?us-ascii?Q?0C//gjU9yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92f46b8-25b0-4a11-71da-08da3212e55a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 23:23:16.4606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QF7qafdlzzUARu7ivVPXFxxaYYdOofLQOaTLFyqZow9F9btJgp1HuA0dxLNP2HqztaHapE1vdU6Qrzo/KN6esw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1614
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Sent: Monday, May 9, 2022 2:48 PM

Thank you Jeff for working out the patches!

Thanks,
-- Dexuan
