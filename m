Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57496755D3C
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jul 2023 09:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjGQHoc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jul 2023 03:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGQHoV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jul 2023 03:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF15E64
        for <linux-hyperv@vger.kernel.org>; Mon, 17 Jul 2023 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689579813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQVhAdPhMy3kA8WlEpRTBlp68XeaAscXbJ2l6phyeAs=;
        b=YnHJz94asRnKzleAtSYb53P6F3YFMzxWXU9lwwtm5K0HteAURcxtUDEpKh2m6bW0FWy58b
        EN8lqv9ni+1e490RvnPssZwAmAj77pjITHf+R1Rn6z8wDMZSiL/oeoCJ+RqOznzUk8TSIN
        2GkHEVEbnw5NzB+Q5fXKyow2sVK7DDU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-ZgtzqEEeN7qMmgJUfHeOVQ-1; Mon, 17 Jul 2023 03:43:31 -0400
X-MC-Unique: ZgtzqEEeN7qMmgJUfHeOVQ-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-56687ec60d4so5555938eaf.0
        for <linux-hyperv@vger.kernel.org>; Mon, 17 Jul 2023 00:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689579810; x=1692171810;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQVhAdPhMy3kA8WlEpRTBlp68XeaAscXbJ2l6phyeAs=;
        b=DYCT08esNG2Yk1xKCIrUYWT3hjyMeTfz2tYYzXuKE5MuAphwbadokxCSru2kWmq3+U
         SGxr1D0Oz9wsSVRrGzaTw2KM9ZgPRZzor4Ch4GgjjXANXuks89vA5IFmTTlBPtq5ICxA
         mwxOe10909ZSUInqrtQPNx/hiJ24nC6ygqf/wzHfpgeYNDbnOBXQ2uphIXeTyhLh0SM1
         tmd9/47UQF4UoeNdIIBKMLZZorKgqbCGQPUDHFgA8BjCorxujCe0G50spALiA0i5lb/J
         czX7s8xZQnIXraClz1tM2SzHCJ58BqC2kRZ4AW5OlEk6h0XBu0dnU+ZWy4yfi8ioO1xS
         Q7TA==
X-Gm-Message-State: ABy/qLbWc/l6o1TQNtPHRUvLYCO0KqzD1b8kv2BHykalqhN3B7S7jg6v
        ZhaUnoGwpQhbfpSGWPVbLF9hIsmeSpwpbQsaBczHMpmb24d+j0hOwLW5zYrMfmGxxJsuBZH9yaa
        4AQZ61Wuo00bURASpKIrI9C5T5NB9W+y/
X-Received: by 2002:a05:6358:90f:b0:134:c37f:4b63 with SMTP id r15-20020a056358090f00b00134c37f4b63mr10463398rwi.2.1689579810585;
        Mon, 17 Jul 2023 00:43:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFK36ibipM0G2rzToLTfIecoh81m8Px1hLNcEbl1T9WmTowhFWmHY6w0sOGmKuUZwVeblBkeQ==
X-Received: by 2002:a05:6358:90f:b0:134:c37f:4b63 with SMTP id r15-20020a056358090f00b00134c37f4b63mr10463390rwi.2.1689579810286;
        Mon, 17 Jul 2023 00:43:30 -0700 (PDT)
Received: from smtpclient.apple ([203.212.242.27])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090a950200b00263f33eef41sm4377184pjo.37.2023.07.17.00.43.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2023 00:43:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] vmbus_testing: fix wrong python syntax for integer value
 comparison
From:   Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230705134408.6302-1-anisinha@redhat.com>
Date:   Mon, 17 Jul 2023 13:13:25 +0530
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <761F02E9-7A80-486B-8CB4-B5E067D7F587@redhat.com>
References: <20230705134408.6302-1-anisinha@redhat.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> On 05-Jul-2023, at 7:14 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
> It is incorrect in python to compare integer values using the "is" =
keyword.
> The "is" keyword in python is used to compare references to two =
objects,
> not their values. Newer version of python3 (version 3.8) throws a =
warning
> when such incorrect comparison is made. For value comparison, "=3D=3D" =
should
> be used.
>=20
> Fix this in the code and suppress the following warning:
>=20
> /usr/sbin/vmbus_testing:167: SyntaxWarning: "is" with a literal. Did =
you mean "=3D=3D"?

Ping =E2=80=A6

>=20
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
> tools/hv/vmbus_testing | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/hv/vmbus_testing b/tools/hv/vmbus_testing
> index e7212903dd1d..4467979d8f69 100755
> --- a/tools/hv/vmbus_testing
> +++ b/tools/hv/vmbus_testing
> @@ -164,7 +164,7 @@ def recursive_file_lookup(path, file_map):
> def get_all_devices_test_status(file_map):
>=20
>         for device in file_map:
> -                if (get_test_state(locate_state(device, file_map)) is =
1):
> +                if (get_test_state(locate_state(device, file_map)) =3D=3D=
 1):
>                         print("Testing =3D ON for: {}"
>                               .format(device.split("/")[5]))
>                 else:
> @@ -203,7 +203,7 @@ def write_test_files(path, value):
> def set_test_state(state_path, state_value, quiet):
>=20
>         write_test_files(state_path, state_value)
> -        if (get_test_state(state_path) is 1):
> +        if (get_test_state(state_path) =3D=3D 1):
>                 if (not quiet):
>                         print("Testing =3D ON for device: {}"
>                               .format(state_path.split("/")[5]))
> --=20
> 2.39.1
>=20

