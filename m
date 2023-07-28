Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058AA766A72
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jul 2023 12:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjG1K07 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jul 2023 06:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjG1K0e (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jul 2023 06:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF33C49E1
        for <linux-hyperv@vger.kernel.org>; Fri, 28 Jul 2023 03:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690539873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxPULaxNBfrPp7VpRK422Tk4/ctS+Y4M7guAF17ROmw=;
        b=hIn7WOrRHQ8qTtKnzWMe4d282qoXQIY6w2z85pKknCmchM9cTzy4l3SGZxa/eXfpovSv1N
        OeFFKLqKgt6+leDaqI1B6mmbn7H/uUIJAS3NcUxZ+CpZF2fYSGrHb7ljCXBt/VErML7aNu
        RmG0TL06zQtz84XDrQgGYDVQCnMgkCQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-QC4oo0EZMKiqKAtxZjW6fA-1; Fri, 28 Jul 2023 06:24:30 -0400
X-MC-Unique: QC4oo0EZMKiqKAtxZjW6fA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fccf211494so1801691e87.0
        for <linux-hyperv@vger.kernel.org>; Fri, 28 Jul 2023 03:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690539869; x=1691144669;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxPULaxNBfrPp7VpRK422Tk4/ctS+Y4M7guAF17ROmw=;
        b=DXrjeCy4P5dIdEsd1AKNCWynKGy9GZn1IS+10+1ivvGyMGKMcSLyc5wwnnYifnkohn
         CX9gGWTHJDX1ZE3esSo4XZHgWDZp0hOetgn1f7BN5rZJweK6RJXQhlKE2iNPCLQIWx+E
         Gv0hzpxdslA4pZXv1T2NpVjnOqzb/R+Q2X1U5EsNHd18mtDK+rm+Al9sGoUhufSKjztL
         snYuOORRXGBGhtT63UoGDka6XY+SeQf8odSqi7Yd2ERTv342mQVJ/4w0lRvho9PSIHKh
         5UwQD4iDqfKFK5EEAp7cJcyAkYUFRW6TsThzcrSoLAyHSPCkR0HN4wtEIz2mkkZIsuQn
         GsSQ==
X-Gm-Message-State: ABy/qLbyiCnO8KHmBVkTgGfPZKQGZ76AXCUah7PHYxlzESNc29wun+oq
        9IeEYzb02fi4R3NLYMhz7l0nmoVRNLmB6rbedYgCHHezjvfN2jZAO19ZBLRTuTaJgeqhXhJ40oW
        Kc/zbaC7OP2yhdN7nCjq++qV+
X-Received: by 2002:ac2:5e79:0:b0:4f8:46e9:9f19 with SMTP id a25-20020ac25e79000000b004f846e99f19mr1381483lfr.1.1690539869068;
        Fri, 28 Jul 2023 03:24:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFHzWYA1OBlcAOqdfrcdIzqWL6Su/1ncGYESOGE8AnmZFxXOlPXYXtLZekFEHB6YWzVzJvrxg==
X-Received: by 2002:ac2:5e79:0:b0:4f8:46e9:9f19 with SMTP id a25-20020ac25e79000000b004f846e99f19mr1381463lfr.1.1690539868732;
        Fri, 28 Jul 2023 03:24:28 -0700 (PDT)
Received: from smtpclient.apple ([115.96.134.213])
        by smtp.gmail.com with ESMTPSA id y18-20020a1c4b12000000b003fbd597bccesm6548258wma.41.2023.07.28.03.24.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:24:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config based
 connection profile in NM
From:   Ani Sinha <anisinha@redhat.com>
In-Reply-To: <53E9AC1D-C907-4B55-97F2-FC10DCD4D470@redhat.com>
Date:   Fri, 28 Jul 2023 15:54:18 +0530
Cc:     Wei Liu <wei.liu@kernel.org>, Olaf Hering <olaf@aepfle.de>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0013CBFD-327E-4849-B7AF-749A027D7744@redhat.com>
References: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20230508095340.2ca1630f.olaf@aepfle.de>
 <ZFknuu+f74e1zHZe@liuwe-devbox-debian-v2>
 <20230508191246.2fcd6eb5.olaf@aepfle.de>
 <ZFkuY4dmwiPsUJ3+@liuwe-devbox-debian-v2>
 <20230523053627.GA10913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <53E9AC1D-C907-4B55-97F2-FC10DCD4D470@redhat.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> On 12-Jul-2023, at 12:32 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 23-May-2023, at 11:06 AM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>>=20
>> On Mon, May 08, 2023 at 05:16:19PM +0000, Wei Liu wrote:
>>> On Mon, May 08, 2023 at 07:12:46PM +0200, Olaf Hering wrote:
>>>> Mon, 8 May 2023 16:47:54 +0000 Wei Liu <wei.liu@kernel.org>:
>>>>=20
>>>>> Olaf, is this a reviewed-by from you? :-)
>>>>=20
>>>> Sorry, I did not review the new functionality, just tried to make =
sure there will be no regression for existing consumers.
>>>=20
>>> Okay, this is fine, too. Thank you for looking into this.
>>>=20
>>>=20
>>>>=20
>>>> Olaf
>>>=20
>>=20
>> Gentle reminder.
>>=20
>=20
> I have a comment about the following change:
>=20
> +		error =3D fprintf(nmfile, "\n[ipv4]\n");
> +		if (error < 0)
> +			goto setval_error;
> +
> +		if (new_val->dhcp_enabled) {
> +			error =3D kvp_write_file(nmfile, "method", "", =
"auto");
> +			if (error < 0)
> +				goto setval_error;
> +		} else {
> +			error =3D kvp_write_file(nmfile, "method", "", =
"manual");
> +			if (error < 0)
> +				goto setval_error;
> +		}
>=20
> I think the method equally would apply for ipv6 as it applies for =
ipv4.=20
> We can use =
https://www.golinuxcloud.com/nmcli-command-examples-cheatsheet-centos-rhel=
/#18_Disable_IPv6_Address_for_ethernet_connection_IPV6INIT as a =
reference.=20
> So setting the method should be common to both ipv4 and ipv6.

Ping =E2=80=A6=20

