Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA493AA4CA
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jun 2021 21:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhFPT4r (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Jun 2021 15:56:47 -0400
Received: from mail-bn7nam10on2134.outbound.protection.outlook.com ([40.107.92.134]:22368
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231602AbhFPT4j (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Jun 2021 15:56:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt/SPorguaJMTlHLyDdbt634Fmu2vgPSKNTjVlIZyoqDbvT0K3J7C88aCpbG1imw5p7+4fpyCkzT7KpV0howU+ZnVE4hMmgtHmqAX30OmjZ6WvbYAISP2FeYAsRVa/pwHCV7Ee9zd0KDUb6nyro4SjQUdxx2kOj/zTqJy7k8BCSbyigXEbceN43AwVaCPOATAtKciJ5d0SuimvA03wBRp1DG39neIVj3R+ZlJdZhjwRXZO+EIcjgWzcxqia/K0J3JhjrZ8CVzptkpgiD4T3d/b+BpPSmn9i56FRk+GHzxDJOxF1KtP2J7YkF5dpiq76nJ/7wIvmY99XK9RwDYWxeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cxKsE33i2edd4h1R0Yzdcl2nj70Es/Uz/8mfx2GkB8=;
 b=T/8DUdB2n7uZjCPEBRbDIyVzmeUdW18ixjUVNGo5Z+tNfFRmwB4IX3NnnGk2wMQZNCHHZEMtdsBsPMt7vf9y59qlGHUfgk8Qb7jYt/phITsWUDh93YEwlKBRwi670MO+r0F2We/roQLhVrj0uiH0VaLmoPVQSKt7KiPLgqxfX9VJsYZHIrR+Z5zNMLyHj/TY6G0wEOKMTalw9/xsFscvg/NR2XDGv/6UONgofq9edS+YZhbRbGk23jhl3D2YDSrYR81zYKegMbT+rG7ALRvzoyuf+r8xSB/blFGCW5xQJi1CgIvA+TO6+YUFZG0lm4hA3JkXivDjuC4eGADkV2Kb5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cxKsE33i2edd4h1R0Yzdcl2nj70Es/Uz/8mfx2GkB8=;
 b=ecBpW2/N6gR4INx8AZ+yt9QbaOtEbLlW2MopZtw6icvSxoWHVhh1mDeduxDE4whc6rkY14MWZWemAioy5EyKX9fLmw40BmctgM8vbHqfDiBtsDLQpi+JMCBia5QhXkKcQV9deIZBqVcSRvEktNKRz/8hvBw2RLp6lbM/aKu5zz8=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1876.namprd21.prod.outlook.com (2603:10b6:303:64::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.3; Wed, 16 Jun
 2021 19:54:29 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::55bf:85c:1abe:d168]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::55bf:85c:1abe:d168%8]) with mapi id 15.20.4264.004; Wed, 16 Jun 2021
 19:54:29 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     KY Srinivasan <kys@microsoft.com>, Long Li <longli@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 1/3] scsi: storvsc: Miscellaneous code cleanups
Thread-Topic: [PATCH 1/3] scsi: storvsc: Miscellaneous code cleanups
Thread-Index: AQHXWWYIAsJ2zwF+KkecbXYDITXaOKsV+udwgAEjtUA=
Date:   Wed, 16 Jun 2021 19:54:29 +0000
Message-ID: <MWHPR21MB1593ABC5154A199022896D3ED70F9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1622827263-12516-1-git-send-email-mikelley@microsoft.com>
 <yq135ti7em1.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq135ti7em1.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=afabda0b-51be-4e6b-993f-bb340e6f98cf;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-16T19:49:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46ae5b96-c6de-4b22-4fd4-08d931008da7
x-ms-traffictypediagnostic: MW4PR21MB1876:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB18768232D51EE846B54F62F7D70F9@MW4PR21MB1876.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S2++C9A4xl4pSE63BbOX93MpigpaWXiG4IndX7WYEQABRSOin4cy+c87loBMkQn+5rB+w2Wt1i6ZuLIh0rjWK4W1mva2l99h4DnDZGGJFtPOJwPbj8B8ZlxaBV/VXl2+18uC0fUKzRUXUr0itkUTARbs09ghevrE1F2Wg/4OQ9q+1qEdmpNaSk0viSfC3kDlwndqedkRjKU27VNG+zTGIkoUNcYulqWrY4d0J0eHcLcUC7REKnSd7Cp/F77l/YlSYTNJSWBfrEdeJvwe2FYT3ES9r1a996FFqcyy7DEuQoZ1hfm48s1O6FbgqG+27KbNYS6D/XWUa08GSnrI93Uyf1DGcUV+dnRbe4IbxmSdEg3ypEpK87KwccsGE/5qf+YB458Ya48zHV74Xf34wkIt6iVsJNdrCp72E4yedHQFVLdKw41SPY81v3DoE6Ix9rqqKRR9wLkk8/7IpdJ++YFOXw7Z9FjFrxlJBGhmtH/A23Bq7Tq0pU52cT0P8GcPtKZ3lxzfI3YHAA92usZ8cHv+wFsykakCuNnWLCgz1uYSb0jnIGXb+gUzKyS/WE10WF/6YvfCb2ipu44z+zK0gL4X6IwGiqusmnpP+MvgVxRjYd360BmAvfaZGzp+4yAPZmwLAw43XZtICPLkURm3wHubWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(478600001)(4744005)(8936002)(8676002)(66556008)(66476007)(82960400001)(66446008)(6916009)(33656002)(64756008)(82950400001)(76116006)(83380400001)(52536014)(71200400001)(6506007)(9686003)(5660300002)(66946007)(7696005)(55016002)(186003)(4326008)(26005)(316002)(2906002)(8990500004)(38100700002)(122000001)(86362001)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n9GQnAsA1X6isPWMS8dZ7OpjshuKJb/CBaz4yk4OUqDi+LK7K9qsU0cd+nPT?=
 =?us-ascii?Q?T1f+fTmjuwQa9kCX7XbSZuw3eNTworosDqASA5JkZU6AyEZ/Z2rWvKtaAjkO?=
 =?us-ascii?Q?fEEdb8G2n+3FdUlTUc0iCu51iRwa/PT7YynDiFoBIX5hlvwl6ehdAdVpSIB/?=
 =?us-ascii?Q?E149Y1bmvYi+ZFGzNTkQjcAwPCyhZmnNK8SgrUA9+cnGMDHlSuMJs9emTfrc?=
 =?us-ascii?Q?ksHbaxAnn/JvXhyxDxSotGdxVTE18TKBTk2wI06mEIJnJ9iqDKuocnly+Uu/?=
 =?us-ascii?Q?bwF0/m8lcKEeG0p4Pjt8bwhM/36paPfJZmfAQ7+zbMPhOoKw6eapgr8fKEJV?=
 =?us-ascii?Q?jhlqwBoGRsu4Ux+wwZqloMtAqxc06w1U/Zafk3NBrJh/juoBEMhWNuOHwMbi?=
 =?us-ascii?Q?tsq+qJSHSey3vgbboVQkKcpt4N/R0Lr4CNsjOSbVcJLX2DbZqkgoRduz6kNb?=
 =?us-ascii?Q?R1CPqG3XO23A5AMy7vb9FzAmbLhUBSps3oD0qIa3avRgGdKKE8AztO4qODHL?=
 =?us-ascii?Q?biNeFDZtVk1dNIxjkYWBWCuA/+BOlYeeyFdiL4BuVV4XXV4t8p2DPOmuG/4C?=
 =?us-ascii?Q?7HBxYXZjjl/ZljHHFn3ehc/9PWqztIasYQmpbuUO16H5t43NRXlLxtwoMaNM?=
 =?us-ascii?Q?MP/UPnd2PGOkyWeKZQFXgnnaSyMwBqmPYmNv8fiZbi/D55+8q6e3qLJMn6zE?=
 =?us-ascii?Q?sA3TNGsa4iVf6Y6WybSMWvaNCrAyfZDCRB/pY51iADCDYILhSkalpYRWYYJw?=
 =?us-ascii?Q?81zcLL6LIF7z+9pZJegiNDtYMVARUEmFrw4olqqGxFnBvdUWumShqaRoF9Eo?=
 =?us-ascii?Q?V1OI35pVvnHXaHJDaFeQdqKeiYeji1XDJvcDJSermpTXP45D5WLmxTteAVtg?=
 =?us-ascii?Q?6aQUnBTOfvaNkgW0XfBlC6qHk7UZE1phVEigcKS2QHVPqLbjLZc8UK8jxEpV?=
 =?us-ascii?Q?thycZqVvuFTWY7vn0oDMdIGCNOBCLjIDXbZdOUkD3uJTu+ssRvmMUioEXEGB?=
 =?us-ascii?Q?GVIQrVtpZ/OPY9Yf2Iv80E+CrL6IRVPvUfhCHxP4n8QtwomI3TQt3BVyWNCI?=
 =?us-ascii?Q?PXxe6PTZkjTEG+a0i1gXea7y2ZdWivdaeG03aSZP3RycOdFQPlnQ5I9mumWk?=
 =?us-ascii?Q?GdWE0YLCoqJWzrtXkrn86kil45rshbJyJm9wsyCG7slm2EMvw81rBEVflJkN?=
 =?us-ascii?Q?9fpzsCeIAKwtXWp2SKo8O7MCndPXbbIKOHq0EYvp+vtUsuwk4AxxyDr03GqU?=
 =?us-ascii?Q?+jWCBNU9s0PxF+/cu7fVZxxKVjpHKgNFeTILyfbxSoXlMCD6ZcpcXA5nYvZ6?=
 =?us-ascii?Q?5g5zRViC/MvAKVgAIuWqU2p/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ae5b96-c6de-4b22-4fd4-08d931008da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 19:54:29.4779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zv4QtddOoiI4gW3ZMQgAK8OI8HmhQZIUWXmUx+IAuofsRLSBQROiFLsZ43TJUAT9krNgX77AW4XkzjT1Y6azaTFqIeiYOGdwlcNihuAlsjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1876
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Martin K. Petersen <martin.petersen@oracle.com> Sent: Tuesday, June 1=
5, 2021 7:25 PM
>=20
> Michael,
>=20
> > As general cleanup and in preparation for subsequent patches:
>=20
> Applied 1-3 to 5.14/scsi-staging.
>=20
> Since Hannes' series has deprecated status_byte() and CHECK_CONDITION I
> had to tweak that portion. Please verify my conflict resolution.
>=20

Unfortunately, it's not quite right.  The line of code in question needs to=
 be

if ((vstor_packet->vm_srb.scsi_status & 0xFF) =3D=3D SAM_STAT_CHECK_CONDITI=
ON &&

The status_byte() helper was doing the masking as well as the right shift, =
so the
masking will need to be open coded.  The replacement get_status_byte() help=
er=20
won't work here because it's based on a scsi_cmnd structure.

Michael
