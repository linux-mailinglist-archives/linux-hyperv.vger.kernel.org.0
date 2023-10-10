Return-Path: <linux-hyperv+bounces-494-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFD07BF1A3
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 05:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7357A281960
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 03:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B72823C1;
	Tue, 10 Oct 2023 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4D415AE
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Oct 2023 03:43:12 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C4B92;
	Mon,  9 Oct 2023 20:43:11 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a24b03e22eso64084637b3.0;
        Mon, 09 Oct 2023 20:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696909391; x=1697514191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaC1CNi7JQmmxrWwxbdaMek4eXwXT8OMu+wQdUBVHH8=;
        b=AlCHB8RLVm/jnH2cdJHHbEWDS5uwiLYvvNGdanxdPiuMKmxQ9TaMTGOE/XBaXOBaN5
         F/Dpl189PjBIoWmrVDmTTvIF155n1qm9qdAgj+tMMnKoggOzDINj4qLh26Kj3chqJSUI
         BmLKyYogNlS9q6VMa2jWNdWYtAoKa0UAT806xstpuIxwobxcZD4QxigAlQyOaTkx0jc6
         6XpvXNpY0ahSC0RpXUxy/JIqn9WhroOWKeqdU+DgpUzMCAaDOzYZIK6BD6fDdr8CreJO
         jxsKcUfgigZq3h1/5pVHQpy4mZUeaHdPFqnTjoJbIX4JmBuhwvsMjUfLUM2Mv2OHWIsy
         Uuxg==
X-Gm-Message-State: AOJu0YyEftlHUqM/nmuW9SiZ9vJiUP1+BUBFiQprFDtZJD9cnfpkjmv/
	wChCeu3Y5PPTzI+FOwUwveyIpX+UoQw=
X-Google-Smtp-Source: AGHT+IGkwXsDV84jHLcmj9BirA1TG3zfHkKLT3nhlSDzWQOoTcDELHL36PAkT1Y8XQgJ48Wzzw412A==
X-Received: by 2002:a81:df04:0:b0:5a1:fb1d:740a with SMTP id c4-20020a81df04000000b005a1fb1d740amr17465761ywn.51.1696909390819;
        Mon, 09 Oct 2023 20:43:10 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9-20020a639909000000b0059b2316be86sm543016pge.46.2023.10.09.20.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 20:43:10 -0700 (PDT)
Date: Tue, 10 Oct 2023 03:43:08 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Ani Sinha <anisinha@redhat.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Olaf Hering <olaf@aepfle.de>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v8] hv/hv_kvp_daemon:Support for keyfile based connection
 profile
Message-ID: <ZSTITGaGzR8wR1+h@liuwe-devbox-debian-v2>
References: <1696847920-31125-1-git-send-email-shradhagupta@linux.microsoft.com>
 <DF08C86E-1EFA-4C74-A5E7-190B52698F85@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DF08C86E-1EFA-4C74-A5E7-190B52698F85@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 05:32:35PM +0530, Ani Sinha wrote:
> 
> 
> > On 09-Oct-2023, at 4:08 PM, Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:
> > 
> > Ifcfg config file support in NetworkManger is deprecated. This patch
> > provides support for the new keyfile config format for connection
> > profiles in NetworkManager. The patch modifies the hv_kvp_daemon code
> > to generate the new network configuration in keyfile
> > format(.ini-style format) along with a ifcfg format configuration.
> > The ifcfg format configuration is also retained to support easy
> > backward compatibility for distro vendors. These configurations are
> > stored in temp files which are further translated using the
> > hv_set_ifconfig.sh script. This script is implemented by individual
> > distros based on the network management commands supported.
> > For example, RHEL's implementation could be found here:
> > https://gitlab.com/redhat/centos-stream/src/hyperv-daemons/-/blob/c9s/hv_set_ifconfig.sh
> > Debian's implementation could be found here:
> > https://github.com/endlessm/linux/blob/master/debian/cloud-tools/hv_set_ifconfig
> > 
> > The next part of this support is to let the Distro vendors consume
> > these modified implementations to the new configuration format.
> > 
> > Tested-on: Rhel9(Hyper-V, Azure)(nm and ifcfg files verified)
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> Reviewed-by: Ani Sinha <anisinha@redhat.com>

Applied to hyperv-fixes. Thanks.

