Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B1C3E513E
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Aug 2021 05:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbhHJDBf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 Aug 2021 23:01:35 -0400
Received: from mail-dm6nam11on2110.outbound.protection.outlook.com ([40.107.223.110]:23520
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233477AbhHJDBf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 Aug 2021 23:01:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpH8i+cSDYrKapLsOqwTosKgodGBHGhDngV+NNhw8gmkNe4CI5Y+CRU3LxNZkJWAot6LqfPVjGaow7tyo78/dlDpuLyW90efpYgJep2hCQmp8egvGl/ZJSRJK1/xQyFSeF9Y249+Hqee1QgDKJrIpBfwbBmI+cY/pyGp7u3sLFG36pjHRroXrjnze/4N9Bc+qyb24BPIgXstYIgwroJqlVn8VCMPgUxg/rLht/dKhA3DjSukTTjkuZgmPqTW6bFwSFKFmI5hh7Y9ssebmQKm8wcB0QirZUEoOj49sPHwE8cEyp0QjFQuC6pQiYY84HAncxuOaIltplAxIW0QuNkmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEQfyXsp1XyEAFWSV2/NrzXd/4RkIxmxtni10k+uhiM=;
 b=DREnpTbjG/30kP+rsuX65oVMt0K1XOVaTvusXqi0bosTDIG5NZ45of6L2BeP4t5DC1VCFVyR7GFW5dClZ+Yl9fERfaSTDQb4JPa1W8Fac1DrzC/ecJ585b+IiMuOAphYdMlEbURRZ76dAfCoxhTRGcPiMvmB91rhnVTlEexn3A+96Sc2D71Yu3GLrO1VAYA4NM9cbk64FxtuFgEfxL6dkeRcx7py3fnpdwEVRtfstopZq+4jcCNJqwbZgJcowcZ+eUAZsLUnZC2iwsKq172+I0dMO51xE85/lRjiQt9trqRxVcvp8xM74e7EV0IXYAlPoJo2fkgDWTExvWIw+LLJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEQfyXsp1XyEAFWSV2/NrzXd/4RkIxmxtni10k+uhiM=;
 b=S8aLiziuPzvBCq9W8gdY8CrY7L3SUDc99jWYj+DGbPydtZ5pG3lqjIj2Krgld84s3JPAN65UkhkvnH63TvtbA6RDZWPKx4F0jwKH6scgIff4dwGKMAVELR2AiikWbOZe5WK5qhWk1L5q8Xg079ggd3JkpXAnw1vJeucLgXOgo+Q=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BY5PR21MB1411.namprd21.prod.outlook.com (2603:10b6:a03:238::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.2; Tue, 10 Aug
 2021 03:01:11 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4%2]) with mapi id 15.20.4436.006; Tue, 10 Aug 2021
 03:01:11 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bart Van Assche <bvanassche@acm.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>
Subject: RE: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
Thread-Topic: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
Thread-Index: AQHXiceSNIn8c8rqq0aMs/Uc2xnVEKtlJaUAgAARXqCAAAZzgIADIFJggAC3SwCAAv3hYA==
Date:   Tue, 10 Aug 2021 03:01:11 +0000
Message-ID: <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
 <BY5PR21MB15060F1B9CDB078189B76404CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQwvL2N6JpzI+hc8@kroah.com>
 <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
In-Reply-To: <YQ9oTBSRyHCffC2k@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3083f4e9-5ea4-47c9-aab1-5be6659653ec;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-10T02:56:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88530125-5f99-4394-66f7-08d95bab1bd6
x-ms-traffictypediagnostic: BY5PR21MB1411:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BY5PR21MB141150B5E0EED58DB74E8918CEF79@BY5PR21MB1411.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: boWGMCc169pwOQlyO/DggMCfgB13uYAcPcFVr2nCs6HOQz32wkPt6oy6sR2hRNbomRrFjmrPdHdNNDHaZN0ALMc39Fr2WzVE/1TUrrj9RIxdx+RvrWfmZHzo0iIuQxi/fBx1O4hRpswybsdzYLSThI+WlF4+oGlYSvB79Rdkjx4Z+eszZUDTn2LEtApGDwtW+UGoATbX0DsqDRi3/adIH3HedD8NqRvTzfoQHUpRufkzUOjTOv0bbF9WthOmrruO2AZ8d/lR5sSnons+cvz9LrdKIsjAUWlAPDFZXOkxLouAdtaEFELvi44xS8HsgwAaIMA/Oip5dei1a3ovrPWqMir0CuMcr8KqWiYgHnusD7uq2j/q7OI8/LJc3rj2pnYmT7rQnhRIpvbQbNMDyPml5ryVN9u/Wx2LuxF/PvdjKheQMaPc15eqSTY4JUeItRK+dF51EEYAhUib7xituvTv4vgitu2d5sR7aawfGXBnlsT6DjbCHcB+PjFlqQB4OJs86G8yN+w5p25oNpkg7463EaHb7PhPOR2o/GRwJ09aX3XDtVDAQ5UXSvKnAo3j72fucjS890o+PsfbFfGTfRwd92BLm/voigX9TV58OixpaksXIeTsZdvVZ35YYqqPN2/x4KLk2UlvTNcrMro0+MCiqFGai/kj1jdTTUXLrBUwXTDO2rp3p5Sz4ivzG9e9qpO6UrnCFbTv3h7JlR4OnEyOrWJAlvsl9gUFVEXKoiLqdcDmFNu2zLSTg/fsIyfUaTe5QQXJYw3haR4aLGuFsHrBPET+Hu3g9hzjYHnhVyEAPOLfX26GNY4WBWXQiARuiCW+s768oPaorDoDkoxmibVYCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(64756008)(52536014)(2906002)(186003)(76116006)(66946007)(66556008)(66476007)(5660300002)(55016002)(66446008)(966005)(26005)(83380400001)(9686003)(122000001)(10290500003)(6506007)(7416002)(54906003)(4326008)(8990500004)(7696005)(38100700002)(71200400001)(508600001)(6916009)(8936002)(8676002)(86362001)(82960400001)(316002)(38070700005)(82950400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e+ZRPPzjmEc0NFBYzOvVTpKKuazIVfDyaMTEs3OMtOnp1ii5rPa9UfUHWL8V?=
 =?us-ascii?Q?d2dTpli+zONxDA3OIFoiOwR8jQAwvLjIpgiA3Y6Td7A9/jphbOZs+S9gVwrc?=
 =?us-ascii?Q?OR3V34bMvL7u5AgV/lxYaYb+C0FVRXTR5bL/fzcaflk6EgWPo2XXJdCpprIK?=
 =?us-ascii?Q?6gL8Qf2CV8kkGOwoiclE6CrM0asfC54vO0bmYVfmbGqXSKH3w34r1JKC9Rhb?=
 =?us-ascii?Q?Ma/6il00UxIsl8MprxlOFeShM9Ml6YNXQNXeoocUDI5Bc2UGewKwNShRrMeF?=
 =?us-ascii?Q?2hkyWt84Jlm628L9pcs/0SQGGQw5juMX7dwWTrBbPf5owq9FXgaPJ98bQ5k8?=
 =?us-ascii?Q?i8ny1n9t4QQMvozbAfDJ8RNjRSDnF3yUXagU4fhy2YY00i/3BEUfEqJ7HTFD?=
 =?us-ascii?Q?J/32Oe2s/y2N419lua7+G/fQZVABrv6yCaYmhh2AuzCFFeWrqMGJ4J6jFWO+?=
 =?us-ascii?Q?MeQlXIAUATTBjf2g2YVc51nyhMyd9JGCanu3tbMmJWTwiY9f8Jci/n0phzgJ?=
 =?us-ascii?Q?SFAYs/qZD5yHV0nYdmFqHoDhyAX5EtIijdDpuyuHXKJQpk3FW5MkiHXnzGXI?=
 =?us-ascii?Q?6MamzHCT+hB8Ph2NUN3fLa2wLmYOsPeSAph7qBEaMML5CNdDfy0wvDS55EIG?=
 =?us-ascii?Q?H7pOX5IxVKdnqMuOdCP2k4Wcp17MES7ta/Rw6mRTG5nTfvMLp6MKQTGJft41?=
 =?us-ascii?Q?xjb/F/WNUrtfk9qF9ppx1j/s7iolYE3zS9zD+bs/K4l3NiLfA1qlLqidtYzz?=
 =?us-ascii?Q?Z5OwOPyAnlXzNc8Xpd8nmkgCSQGn/mITNJKi4ZKoBmGSnHKSKUrZTY46OJjA?=
 =?us-ascii?Q?yinbXbjXrvgJywI5nV9qCZ/TPk3Ebs9+92KDYLh9O0ugXBk6DHROXQUcdFP0?=
 =?us-ascii?Q?nJvksJ/i9vxKQdJM9mYH0p29rA4GIz1zzzL9xGU9Rq+aYA7YT7f+MAhPvIxV?=
 =?us-ascii?Q?zxpwvyozioBtd+7ePujwmtHWeyMhrz9PV4EXHyMUxQo3ODfgYjwyu5vQMDmk?=
 =?us-ascii?Q?8SgLGLoHgDr5kFyJDZp7igezSB82WOwEiRY+XLoaQh9TW3JQ8zAwuSNf1Q+o?=
 =?us-ascii?Q?D8WEnf+x6vD0P0b2VIDjfclKHWv8KaY8XD1AnL0LvN18+BBDhOjeOAYl61J4?=
 =?us-ascii?Q?T5pIdEHAwofpG+57I62KGsT3pyGN9frkHXk6LELbbwD/XDdGnSKCdAMfMybS?=
 =?us-ascii?Q?yNbJcMRxRk+VJ9wb0MuLB9lKLPiTXzq7rUKe4jgWygNk9BBdLz5p+I8qFA1k?=
 =?us-ascii?Q?20RywR3iaZV2VYd2BT8afGjqMKUx4tX6D6Iigch6YlYya22sa/ClG5NFYSIn?=
 =?us-ascii?Q?iDCnkPghjPFXoNwkhmg6v1nh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88530125-5f99-4394-66f7-08d95bab1bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 03:01:11.1737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hU9NeEcUwQXLc5cMSFkAye7MQZII9jGhQAGapFw6tXlniLQ3AHD/x56fa3Nxh+C8C6gI7ysgb7Z1J3Tr2Pn55g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1411
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerate=
d
> access to Microsoft Azure Blob for Azure VM
>=20
> On Sat, Aug 07, 2021 at 06:29:06PM +0000, Long Li wrote:
> > > I still think this "model" is totally broken and wrong overall.
> > > Again, you are creating a custom "block" layer with a character
> > > device, forcing all userspace programs to use a custom library (where=
 is it
> at?) just to get their data.
> >
> > The Azure Blob library (with source code) is available in the following
> languages:
> > Java:
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2FAzure%2Fazure-sdk-for-
> java%2Ftree%2Fmain%2Fsdk%2Fstorage%2Faz
> > ure-storage-
> blob&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C778083147
> >
> 8ed49b16e6308d95a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7C1
> %7C0%7C6
> >
> 37639965101378114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoi
> >
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DwcNhsEoH
> LV0VBc
> > uDf0CVXl7W0Ug9Cj7Q92%2Bw6qizroU%3D&amp;reserved=3D0
> > JavaScript:
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2FAzure%2Fazure-sdk-for-
> js%2Ftree%2Fmain%2Fsdk%2Fstorage%2Fstor
> > age-
> blob&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C7780831478ed49b
> 16
> >
> e6308d95a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C
> 637639965
> >
> 101378114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo
> iV2luMzIi
> >
> LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DI%2FfhdPX3Unz6S3
> eBPcpl
> > %2Bh55nKoV0u%2FO0%2BYgjLy4grQ%3D&amp;reserved=3D0
> > Python:
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2FAzure%2Fazure-sdk-for-
> python%2Ftree%2Fmain%2Fsdk%2Fstorage%2F
> > azure-storage-
> blob&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C7780831
> >
> 478ed49b16e6308d95a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7
> C1%7C0%7
> >
> C637639965101378114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIj
> >
> oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DaAwsi%2
> BPVsN
> > tsDMJ7rKnRDigNc41fIao031lde247Nc0%3D&amp;reserved=3D0
> > Go:
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2FAzure%2Fazure-storage-blob-
> go&amp;data=3D04%7C01%7Clongli%40mic
> >
> rosoft.com%7C7780831478ed49b16e6308d95a2b7ae8%7C72f988bf86f141a
> f91ab2d
> >
> 7cd011db47%7C1%7C0%7C637639965101378114%7CUnknown%7CTWFpbG
> Zsb3d8eyJWIj
> >
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10
> 00&am
> >
> p;sdata=3D43JhbGsYQxA%2FoivNd7C3z7DSYO%2FPONCoaW2v7TN6xEU%3D&a
> mp;reserve
> > d=3D0
> > .NET:
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2FAzure%2Fazure-sdk-for-
> net%2Ftree%2Fmain%2Fsdk%2Fstorage%2FAzu
> >
> re.Storage.Blobs&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C77808
> 3147
> >
> 8ed49b16e6308d95a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7C1
> %7C0%7C6
> >
> 37639965101378114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoi
> >
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D6ClMeURlt
> cBv1q
> > 7l7PGGrxXVJbVDt9uMBlwoIVh7Wpw%3D&amp;reserved=3D0
> > PHP:
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2FAzure%2Fazure-storage-php%2Ftree%2Fmaster%2Fazure-
> storage-blo
> >
> b&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C7780831478ed49b16
> e6308d9
> >
> 5a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6376399
> 651013781
> >
> 14%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> LCJBTiI
> >
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DDuZO539vd76c%2Byaqjn
> hetp%2B3T
> > i0b74601ZkNe39SNK4%3D&amp;reserved=3D0
> > Ruby:
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2Fazure%2Fazure-storage-
> ruby%2Ftree%2Fmaster%2Fblob&amp;data=3D04
> > %7C01%7Clongli%40microsoft.com%7C7780831478ed49b16e6308d95a2b
> 7ae8%7C72
> >
> f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637639965101378114%7
> CUnknown%
> >
> 7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> LCJX
> >
> VCI6Mn0%3D%7C1000&amp;sdata=3D6Zviu1IuRQE2do9bDCae2iJv0W2KOJu90t
> XSR6kDAR
> > 4%3D&amp;reserved=3D0
> > C++:
> >
> C++https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg
> > C++ithub.com%2FAzure%2Fazure-sdk-for-
> cpp%2Ftree%2Fmain%2Fsdk%2Fstorage
> > C++%23azure-storage-client-library-for-
> c&amp;data=3D04%7C01%7Clongli%40m
> >
> C++icrosoft.com%7C7780831478ed49b16e6308d95a2b7ae8%7C72f988bf86
> f141af9
> >
> C++1ab2d7cd011db47%7C1%7C0%7C637639965101388074%7CUnknown%
> 7CTWFpbGZsb3
> >
> C++d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3
> >
> C++D%7C1000&amp;sdata=3DHH6jrqREWQ%2BkoRR%2Fsb02wRXnuLU5il4Erzm
> rBvUZu5w%
> > C++3D&amp;reserved=3D0
>=20
> And why wasn't this linked to in the changelog here?
>=20
> In looking at the C code above, where is the interaction with this Linux =
driver?
> I can't seem to find it...

Those are existing Blob client libraries. The new code using this driver is=
 being
tested and has not been released to github.

I'm sorry I misunderstood your request. I'm asking the team to share the ne=
w
code for review. I will send the code location for review soon.

Thanks,
Long
