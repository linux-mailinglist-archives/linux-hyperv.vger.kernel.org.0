Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42B16AC5AF
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Mar 2023 16:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCFPmJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Mar 2023 10:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCFPmI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Mar 2023 10:42:08 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E167367DD;
        Mon,  6 Mar 2023 07:41:39 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so8501649wms.2;
        Mon, 06 Mar 2023 07:41:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678117260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnptPmBeBG9/UpqmcXci6KGnzjUxqow5ngyjB6yqkjU=;
        b=S6TTFchSGE1RPZnaGW6J0Lo0qqNJiHMukCvA7QLeIYQNuzErlRyHq/Qsao79U6pGoB
         bWlJehgdc80K6GWLFOoBTHfz7Yz9Neve2la0YlC26POD+/5dGamHO2yubkbymJY5gdwl
         1IUvwNjrxx5NcX0E6D8L3hrc9Gszwt+CcBfYMwz2qGC0f0cB2zlCB4BQYEhvAKr692wC
         rzFc7Kr7Ul4nd/RSDWnAYY7gFUnSTgTGwyh1HOkbn8MjTzHJZjcq68Bw8N3Cp0NVrwGj
         vHgvYkrVExnEYO+6u3Bfy72eImod/mp30xHn2hrGssUD6yp/ytULX2M2rMn+jYLlzkM+
         5uuA==
X-Gm-Message-State: AO0yUKXdaB8NWDGkPbGf1Bz38fzUmPNepAWCW7OBCd8L3coQ3lD8uljD
        2PxB5k+jECB11dy5Rkk9B3E=
X-Google-Smtp-Source: AK7set8VddkFcebK6rvUAY6JclpJQVJN8hLTX5/40ay/phMPQNmyWd5Vma+DwvuCAodpWPsU67obQw==
X-Received: by 2002:a05:600c:3504:b0:3ea:e677:5017 with SMTP id h4-20020a05600c350400b003eae6775017mr9794612wmq.8.1678117259721;
        Mon, 06 Mar 2023 07:40:59 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id he5-20020a05600c540500b003e2058a7109sm14214668wmb.14.2023.03.06.07.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:40:59 -0800 (PST)
Date:   Mon, 6 Mar 2023 15:40:54 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] hv/hv_kvp_daemon: Add support for keyfile config based
 connection profile in NM
Message-ID: <ZAYJhm9fVAgCtTiC@liuwe-devbox-debian-v2>
References: <1677133334-6958-1-git-send-email-shradhagupta@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1677133334-6958-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 22, 2023 at 10:22:14PM -0800, Shradha Gupta wrote:
> As communicated in BZ <2122115>, ifcfg config file support in

What is BZ <2122115>? I guess that's Red Hat's bugzilla?

I don't think this is useful information for the commit message, since
the community cannot access that ticket.

> NetworkManger is deprecated. This patch provides support for the
> new keyfile config format for connection profiles in NetworkManager.
> The patch modifies the hv_kvp_daemon code to generate the new network
> configuration in keyfile format(.ini-style format) instead of ifcfg
> format.

Okay, so the wire protocol for the KVP daemon is not changed. It is just
the intermediate file format that's changed.

> This configuration is stored in a temp file which is further translated
> using the hv_set_ifconfig.sh script. This script is implemented by
> individual distros based on the network management commands supported.
> For example, RHEL's implementation could be found here:
> https://gitlab.com/redhat/centos-stream/src/hyperv-daemons/-/blob/c9s/hv_set_ifconfig.sh
> Debian's implementation could be found here:
> https://github.com/endlessm/linux/blob/master/debian/cloud-tools/hv_set_ifconfig
> 
> The next part of this support is to inform the Distro vendors to
> modify these implementations to consume the new configuration format.
> 

I guess they will figure out the format has changed when they upgrade to
a new kernel?

Thanks,
Wei.
