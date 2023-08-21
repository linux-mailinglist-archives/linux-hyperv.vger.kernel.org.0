Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DA3782AC4
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Aug 2023 15:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjHUNpr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Aug 2023 09:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjHUNpq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Aug 2023 09:45:46 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AA78D1;
        Mon, 21 Aug 2023 06:45:45 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id EC690211FA3C; Mon, 21 Aug 2023 06:45:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC690211FA3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692625544;
        bh=i6sSligzEo8tt4Xole1NwK3cDCe/Ed1x0JSoXtIQuac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=saOtpeOMtJQGP9H29A0TdzJicKfUJBARLOslY1Q2+F3EEbVvldk+9rdZ0kY46dwXu
         777nSU9qKWTBpNAkrx+hzJBybgACYNYiWL0UjSMBcsP25P2IwH3LDCEvGsHnZjh71e
         QmhYqdsTEr9P+7XGDROtrjf/0mn6aI9X4FeV5RM4=
Date:   Mon, 21 Aug 2023 06:45:44 -0700
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     Ani Sinha <anisinha@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Olaf Hering <olaf@aepfle.de>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config
 based connection profile in NM
Message-ID: <20230821134544.GA5052@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20230508095340.2ca1630f.olaf@aepfle.de>
 <ZFknuu+f74e1zHZe@liuwe-devbox-debian-v2>
 <20230508191246.2fcd6eb5.olaf@aepfle.de>
 <ZFkuY4dmwiPsUJ3+@liuwe-devbox-debian-v2>
 <20230523053627.GA10913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <53E9AC1D-C907-4B55-97F2-FC10DCD4D470@redhat.com>
 <4142F3A4-8AB4-4DE2-8D03-D3A8F8776BF9@redhat.com>
 <20230808054248.GA12620@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <5A8AA269-FBDB-4023-9809-273C046B2BCD@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A8AA269-FBDB-4023-9809-273C046B2BCD@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 21, 2023 at 12:15:29PM +0530, Ani Sinha wrote:
> 
> 
> > On 08-Aug-2023, at 11:12 AM, Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:
> > 
> > On Tue, Aug 08, 2023 at 10:41:21AM +0530, Ani Sinha wrote:
> >> 
> >> 
> >>> On 12-Jul-2023, at 12:32 PM, Ani Sinha <anisinha@redhat.com> wrote:
> >>> 
> >>> 
> >>> 
> >>>> On 23-May-2023, at 11:06 AM, Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:
> >>>> 
> >>>> On Mon, May 08, 2023 at 05:16:19PM +0000, Wei Liu wrote:
> >>>>> On Mon, May 08, 2023 at 07:12:46PM +0200, Olaf Hering wrote:
> >>>>>> Mon, 8 May 2023 16:47:54 +0000 Wei Liu <wei.liu@kernel.org>:
> >>>>>> 
> >>>>>>> Olaf, is this a reviewed-by from you? :-)
> >>>>>> 
> >>>>>> Sorry, I did not review the new functionality, just tried to make sure there will be no regression for existing consumers.
> >>>>> 
> >>>>> Okay, this is fine, too. Thank you for looking into this.
> >>>>> 
> >>>>> 
> >>>>>> 
> >>>>>> Olaf
> >>>>> 
> >>>> 
> >>>> Gentle reminder.
> >>>> 
> >>> 
> >>> I have a comment about the following change:
> >>> 
> >>> +		error = fprintf(nmfile, "\n[ipv4]\n");
> >>> +		if (error < 0)
> >>> +			goto setval_error;
> >>> +
> >>> +		if (new_val->dhcp_enabled) {
> >>> +			error = kvp_write_file(nmfile, "method", "", "auto");
> >>> +			if (error < 0)
> >>> +				goto setval_error;
> >>> +		} else {
> >>> +			error = kvp_write_file(nmfile, "method", "", "manual");
> >>> +			if (error < 0)
> >>> +				goto setval_error;
> >>> +		}
> >>> 
> >>> I think the method equally would apply for ipv6 as it applies for ipv4. 
> >>> We can use https://www.golinuxcloud.com/nmcli-command-examples-cheatsheet-centos-rhel/#18_Disable_IPv6_Address_for_ethernet_connection_IPV6INIT as a reference. 
> >>> So setting the method should be common to both ipv4 and ipv6.
> >> 
> >> Ping once more ???
> >> Can anyone comment on the avove and/or review the patchset?
> > That's correct Ani, this needs to be enabled for ipv6 as well, will send out another version. Thanks for catching this.
> 
> Have you sent out a new version? I do not see anything in my inbox.
> >
Not yet, waiting for a few IPv6 related testing to complete on the patch. Will send out the new version as soon as that is done. 
