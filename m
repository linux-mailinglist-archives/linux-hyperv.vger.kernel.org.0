Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FB774FFD7
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jul 2023 09:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGLHDm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jul 2023 03:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGLHDl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jul 2023 03:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658C8B1
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Jul 2023 00:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689145374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wufi9rv0SDzDYEN3qmZtEV5G7f/6JaOzjp0WTDKMnGU=;
        b=dYGf7wYG2lGVIIquXWfoAcfdKadqulXk3XVN8J8uCQDya8ulQDkU4KiEDpYr2gSZlyewAj
        x+uU28xJj3pqKm5eKba2BLpbSgKg2Gd7+3owjRCsNR3nCVo2cJR5KfXPXlLWz3aDyWoa2/
        6bs/+MZSpNZ55XfB4nntwMrUN2ZukvI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-tpxVkAkbM_u3UC6HJERKsA-1; Wed, 12 Jul 2023 03:02:53 -0400
X-MC-Unique: tpxVkAkbM_u3UC6HJERKsA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b895fa8929so70329685ad.0
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Jul 2023 00:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689145372; x=1691737372;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wufi9rv0SDzDYEN3qmZtEV5G7f/6JaOzjp0WTDKMnGU=;
        b=cG184ARD1yGhG7jEMHdYTiiUxtI37/1PrtWF1vQ0c/beieOs/wuk5skR4zeu3FH89P
         gmmMPriNCboTdW3DgVWbAyfgpGN74KXsaXxYOqQz4m2FDFWJjPzWzSf9TYTx9W151bwe
         xEpR423GEHHTOTmWo55VYl6M6D8Ia2uU90/Ad0LeJdsEL095TkU9dbI21XbYTKAXW8LB
         AKr1LutNLpQQ7GNdpNb9LP7ERlzqPiD4EC5si3LZkfcfPBX8ufeYQSVVk2l9Dir6J2lA
         CixOKgnEqwLlCNq+ffy6mTiHBP/PM88//lOcUwfRm4FHL4Hu9N4/gpmulINzzM5MMqVV
         rhKQ==
X-Gm-Message-State: ABy/qLZeplkX3ybp59s3AwCCfQzvKiMEkZpztwVAmKICGFUMZJKikuOZ
        JakFYW5/VVtXOra+neTAgAiCrI+Tg2tTO0qezAVlvNDGby2hcHg0kDm5MxVdhdgQ33sDiLp/Q7D
        Em06Wi84J8bkPU287om+jC2CvJNEYbWNj
X-Received: by 2002:a17:902:f68c:b0:1b8:c1f:fcfc with SMTP id l12-20020a170902f68c00b001b80c1ffcfcmr15621555plg.11.1689145371884;
        Wed, 12 Jul 2023 00:02:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHb0dBFUiexF5mmKYCB06wLwX90g+ILyNJsPf1yZNNVkvuX1bBpUE1JjXI0J1CJtA5DWyyAeA==
X-Received: by 2002:a17:902:f68c:b0:1b8:c1f:fcfc with SMTP id l12-20020a170902f68c00b001b80c1ffcfcmr15621546plg.11.1689145371595;
        Wed, 12 Jul 2023 00:02:51 -0700 (PDT)
Received: from smtpclient.apple ([115.96.113.77])
        by smtp.gmail.com with ESMTPSA id d5-20020a170903230500b001b672af624esm3143511plh.164.2023.07.12.00.02.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2023 00:02:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config based
 connection profile in NM
From:   Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230523053627.GA10913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Date:   Wed, 12 Jul 2023 12:32:43 +0530
Cc:     Wei Liu <wei.liu@kernel.org>, Olaf Hering <olaf@aepfle.de>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <53E9AC1D-C907-4B55-97F2-FC10DCD4D470@redhat.com>
References: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20230508095340.2ca1630f.olaf@aepfle.de>
 <ZFknuu+f74e1zHZe@liuwe-devbox-debian-v2>
 <20230508191246.2fcd6eb5.olaf@aepfle.de>
 <ZFkuY4dmwiPsUJ3+@liuwe-devbox-debian-v2>
 <20230523053627.GA10913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> On 23-May-2023, at 11:06 AM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>=20
> On Mon, May 08, 2023 at 05:16:19PM +0000, Wei Liu wrote:
>> On Mon, May 08, 2023 at 07:12:46PM +0200, Olaf Hering wrote:
>>> Mon, 8 May 2023 16:47:54 +0000 Wei Liu <wei.liu@kernel.org>:
>>>=20
>>>> Olaf, is this a reviewed-by from you? :-)
>>>=20
>>> Sorry, I did not review the new functionality, just tried to make =
sure there will be no regression for existing consumers.
>>=20
>> Okay, this is fine, too. Thank you for looking into this.
>>=20
>>=20
>>>=20
>>> Olaf
>>=20
>=20
> Gentle reminder.
>=20

I have a comment about the following change:

+		error =3D fprintf(nmfile, "\n[ipv4]\n");
+		if (error < 0)
+			goto setval_error;
+
+		if (new_val->dhcp_enabled) {
+			error =3D kvp_write_file(nmfile, "method", "", =
"auto");
+			if (error < 0)
+				goto setval_error;
+		} else {
+			error =3D kvp_write_file(nmfile, "method", "", =
"manual");
+			if (error < 0)
+				goto setval_error;
+		}

I think the method equally would apply for ipv6 as it applies for ipv4.=20=

We can use =
https://www.golinuxcloud.com/nmcli-command-examples-cheatsheet-centos-rhel=
/#18_Disable_IPv6_Address_for_ethernet_connection_IPV6INIT as a =
reference.=20
So setting the method should be common to both ipv4 and ipv6.

